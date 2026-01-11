# rails g model OrderItem order:references product:references product_code:string product_name:string unit_price:decimal tax_percentage:decimal quantity:integer tax_amount:decimal line_total:decimal
class CreateOrderItems < ActiveRecord::Migration[7.1]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, foreign_key: true

      t.string  :product_code, null: false
      t.string  :product_name, null: false
      t.decimal :unit_price, precision: 10, scale: 2, null: false
      t.decimal :tax_percentage, precision: 5, scale: 2, null: false
      t.integer :quantity, null: false
      t.decimal :tax_amount, precision: 10, scale: 2, null: false
      t.decimal :line_total, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
