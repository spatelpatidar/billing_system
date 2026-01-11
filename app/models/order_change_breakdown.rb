class OrderChangeBreakdown < ApplicationRecord
  belongs_to :order

  validates :denomination_value, presence: true,
                                 numericality: { greater_than: 0 }

  validates :count, presence: true,
                    numericality: { only_integer: true, greater_than: 0 }
end
