class Vehicle < ApplicationRecord
  validates_presence_of :make_id,
                       :model_id,
                       :year_id
  validates :vin, presence: true, uniqueness: true

  belongs_to :make
  belongs_to :model
  belongs_to :year
  has_many :vehicle_options

  has_many :options, through: :vehicle_options
end
