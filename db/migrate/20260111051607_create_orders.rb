# rails g model Order customer:references subtotal_amount:decimal total_tax:decimal grand_total:decimal cash_paid:decimal
class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.decimal :subtotal_amount, precision: 10, scale: 2, null: false
      t.decimal :total_tax, precision: 10, scale: 2, null: false
      t.decimal :grand_total, precision: 10, scale: 2, null: false
      t.decimal :cash_paid, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
