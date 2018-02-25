class Make < ApplicationRecord
  validates :company, presence: true, uniqueness: true
  validates_presence_of :company_desc

  has_many :models, :dependent => :destroy
end
