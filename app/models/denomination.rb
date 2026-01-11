class Denomination < ApplicationRecord
  validates :value, uniqueness: true
end
