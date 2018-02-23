class Model < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  belongs_to :make
end
