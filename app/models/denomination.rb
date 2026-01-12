class Denomination < ApplicationRecord
  validates :value, presence: true, numericality: { greater_than: 0 }
  validates :available_count, presence: true, numericality: { greater_than_or_equal_to: 0 }

  validates :value, uniqueness: true
end
