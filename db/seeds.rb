# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

puts "Seeding denominations..."

[2000, 500, 200, 100, 50, 20, 5, 2, 1].each do |value|
  Denomination.find_or_create_by!(value: value) do |d|
    d.available_count = 500
  end
end

puts "Seeding products..."

products = [
  { product_code: "P1001", name: "Pen",      unit_price: 10.00, tax_percentage: 5,  stock_quantity: 100 },
  { product_code: "P1002", name: "Notebook", unit_price: 50.00, tax_percentage: 12, stock_quantity: 50 },
  { product_code: "P1003", name: "Bag",      unit_price: 500.00, tax_percentage: 18, stock_quantity: 20 },
  { product_code: "P1004", name: "Pencile",  unit_price: 10.00, tax_percentage: 5,  stock_quantity: 80 },
  { product_code: "P1005", name: "Eraser",   unit_price: 10.00, tax_percentage: 5,  stock_quantity: 80 },

]

products.each do |attrs|
  Product.find_or_create_by!(product_code: attrs[:product_code]) do |p|
    p.assign_attributes(attrs)
  end
end

puts "Seeding complete ✅"
