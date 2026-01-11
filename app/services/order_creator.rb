class OrderCreator
  def initialize(email:, items:, payments:, cash_paid:)
    @customer = Customer.find_or_create_by!(email: email)
    @items = items
    @payments = payments
    @cash_paid = cash_paid
  end

  def call
    ActiveRecord::Base.transaction do
      build_order
      build_items
      build_payments
      calculate_change
      @order
    end
  end

  private

  def build_order
    @order = Order.create!(
      customer: @customer,
      subtotal_amount: 0,
      total_tax: 0,
      grand_total: 0,
      cash_paid: @cash_paid
    )
  end

  def build_items
    subtotal = 0
    tax_total = 0

    @items.each do |item|
      product = Product.lock.find_by!(product_code: item[:product_code])
      raise "Insufficient stock" if product.stock_quantity < item[:quantity]

      line_price = product.unit_price * item[:quantity]
      tax = (line_price * product.tax_percentage) / 100

      OrderItem.create!(
        order: @order,
        product: product,
        product_code: product.product_code,
        product_name: product.name,
        unit_price: product.unit_price,
        tax_percentage: product.tax_percentage,
        quantity: item[:quantity],
        tax_amount: tax,
        line_total: line_price + tax
      )

      product.update!(stock_quantity: product.stock_quantity - item[:quantity])

      subtotal += line_price
      tax_total += tax
    end

    grand_total = (subtotal + tax_total).round

    @order.update!(
      subtotal_amount: subtotal,
      total_tax: tax_total,
      grand_total: grand_total
    )
  end

  def build_payments
    @payments.each do |value, count|
      OrderPayment.create!(
        order: @order,
        denomination_value: value,
        count: count
      )
    end
  end

  def calculate_change
    change = @order.cash_paid - @order.grand_total
    raise "Insufficient payment" if change < 0

    Denomination.order(value: :desc).each do |d|
      next if change <= 0

      max_notes = [(change / d.value).to_i, d.available_count].min
      next if max_notes.zero?

      OrderChangeBreakdown.create!(
        order: @order,
        denomination_value: d.value,
        count: max_notes
      )

      d.update!(available_count: d.available_count - max_notes)
      change -= max_notes * d.value
    end

    raise "Cannot return exact change" unless change.zero?
  end
end