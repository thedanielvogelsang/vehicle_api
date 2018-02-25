class Vehicle < ApplicationRecord
  validates_presence_of :make_id,
                       :model_id

  validates :vin, presence: true, uniqueness: true

  belongs_to :make
  belongs_to :model
  has_many :vehicle_options, :dependent => :destroy

  has_many :options, through: :vehicle_options, :dependent => :destroy
end
