# rails g model Product product_code:string name:string unit_price:decimal tax_percentage:decimal stock_quantity:integer
class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string  :product_code, null: false
      t.string  :name, null: false
      t.decimal :unit_price, precision: 10, scale: 2, null: false
      t.decimal :tax_percentage, precision: 5, scale: 2, null: false
      t.integer :stock_quantity, null: false, default: 0

      t.timestamps
    end

    add_index :products, :product_code, unique: true
  end
end
