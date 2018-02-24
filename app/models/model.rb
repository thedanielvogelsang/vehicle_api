class Model < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :year_id, presence: true
  
  belongs_to :make
  belongs_to :year
  has_many :options
  has_many :vehicles
end
