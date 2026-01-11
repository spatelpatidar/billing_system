class Product < ApplicationRecord
  has_many :order_items

  validates :product_code, :name, presence: true
  validates :unit_price, :tax_percentage, numericality: { greater_than_or_equal_to: 0 }
end
