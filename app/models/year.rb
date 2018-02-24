class Year < ApplicationRecord
  validates :year, presence: true, uniqueness: true
end
