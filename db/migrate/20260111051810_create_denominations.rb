# rails g model Denomination value:integer available_count:integer
class CreateDenominations < ActiveRecord::Migration[7.1]
  def change
    create_table :denominations do |t|
      t.integer :value, null: false
      t.integer :available_count, null: false, default: 0

      t.timestamps
    end

    add_index :denominations, :value, unique: true
  end
end
