# rails g model OrderChangeBreakdown order:references denomination_value:integer count:integer
class CreateOrderChangeBreakdowns < ActiveRecord::Migration[7.1]
  def change
    create_table :order_change_breakdowns do |t|
      t.references :order, null: false, foreign_key: true
      t.integer :denomination_value, null: false
      t.integer :count, null: false

      t.timestamps
    end
  end
end
