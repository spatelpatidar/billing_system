class OrdersController < ApplicationController
  before_action :load_form_data, only: [:new, :create]

  def customer_orders
    @customer = Customer.find_by!(email: params[:email])
    @orders = @customer.orders.order(created_at: :desc)
  end

  def new
    @order = Order.new
  end

  def create
    creator = OrderCreator.new(
      email: order_params[:email],
      items: build_items,
      payments: build_payments,
      cash_paid: params[:cash_paid].to_i
    )

    @order = creator.call
    OrderMailer.bill_email(order: @order).deliver_later
    redirect_to @order, notice: "Order created successfully"
  rescue StandardError => e
    flash.now[:alert] = e.message
    render :new, status: :unprocessable_entity
  end

  def show
    @order = Order
      .includes(:order_items, :order_payments, :order_change_breakdowns, :customer)
      .find(params[:id])
  end

  def search
    customer = Customer.find_by(email: params[:email])

    if customer && customer.orders.exists?
      redirect_to customer_orders_path(email: params[:email])
    else
      redirect_to new_order_path(order: { email: params[:email] }),
                  alert: "No previous purchases found. Create a new bill."
    end
  end

  private

  def load_form_data
    @products = Product.all
    @denominations = Denomination.order(value: :desc)
  end

  def order_params
    params.require(:order).permit(:email)
  end

  def build_items
    params[:items].values.map do |item|
      {
        product_code: item[:product_code],
        quantity: item[:quantity].to_i
      }
    end
  end

  def build_payments
    params
      .require(:payments)
      .permit!
      .to_h
      .each_with_object({}) do |(value, count), hash|
        count = count.to_i
        next if count <= 0

        hash[value.to_i] = count
      end
  end
end
