class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  has_many :order_payments, dependent: :destroy
  has_many :order_change_breakdowns, dependent: :destroy
end
