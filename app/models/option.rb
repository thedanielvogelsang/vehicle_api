class Option < ApplicationRecord
  validates_presence_of :name,
                        :description,
                        :price
  belongs_to :model

  before_validation(on: :create) do
    self.price = nil if attribute_present?('price') && self.price == 0.0
  end

end
