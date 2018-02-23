require 'rails_helper'
require_relative './honda_description'

RSpec.describe Make, type: :model do
  context 'validations' do

    it{is_expected.to validate_presence_of(:name) }
    it{should belong_to(:make) }

    it 'is created with valid attributes' do
      Make.new(company: 'Honda', company_desc: DESC)
      invalid_1 = Model.new(name: 'Civic')
      invalid_2 = Model.new(make: 1)
      valid_model = Model.new(name: 'Civic', make: 1)

      expect(invalid_1.class).to be(Model)
      expect(invalid_1.save).to be false
      expect(invalid_2.save).to be false
      expect(valid_model.save).to be true
      expect(valid_model.make.company).to eq('Honda')
    end
  end
end
