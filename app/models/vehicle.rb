class Vehicle < ApplicationRecord
  belongs_to :make
  belongs_to :model
  belongs_to :year
  has_many :options
end
