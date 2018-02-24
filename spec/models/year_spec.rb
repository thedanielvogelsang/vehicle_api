require 'rails_helper'
require 'database_cleaner'

RSpec.describe Year, type: :model do
  context 'validations' do

    it{is_expected.to validate_presence_of(:year) }

    it 'is created with valid attributes' do
    # year must must be present and integer
      invalid_1 = Year.new(year: 'Civic')
      invalid_2 = Year.new()
      valid_year = Year.new(year: 1995)
    #integers only
      expect(invalid_1.year).to be 0
    # valid attributes
      expect(invalid_2.class).to be(Year)
      expect(invalid_2.save).to be false
      expect(valid_year.save).to be true
      expect(valid_year.year).to eq(1995)

    # year uniqueness
      invalid_3 = Year.new(year: 1995)
      expect(invalid_3.save).to be false
    end
  end
end
