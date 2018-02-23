require 'rails_helper'
require_relative './honda_description'

RSpec.describe Make, type: :model do
  context 'validations' do

    it{is_expected.to validate_presence_of(:company) }
    it{is_expected.to validate_presence_of(:company_desc) }

    it 'is created with valid attributes' do
    #company and company_desc must be present
      invalid_1 = Make.new(company: 'Honda', company_motto: 'good products come from clean workplaces')
      invalid_2 = Make.new(ceo_statement: 'Hello', company_motto: 'good products come from clean workplaces')
      valid_make = Make.new(company: 'Honda', company_desc: DESC)
      expect(invalid_1.class).to be(Make)
      expect(invalid_1.save).to be false
      expect(invalid_2.save).to be false
      expect(valid_make.save).to be true

    # name uniqueness
      invalid_3 = Make.new(company: 'Honda', company_desc: DESC)
      expect(invalid_3.save).to be false
    end
  end
end
