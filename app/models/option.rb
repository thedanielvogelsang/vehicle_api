class Option < ApplicationRecord
  validates_presence_of :name,
                        :description,
                        :price
  belongs_to :model

  has_many :vehicle_options
  has_many :vehicles, through: :vehicle_options

  before_validation(on: :create) do
    self.price = nil if attribute_present?('price') && self.price == 0.0
  end

end
