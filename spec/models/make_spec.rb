require 'rails_helper'
require_relative './honda_description'

RSpec.describe Make, type: :model do
  context 'validations' do
    invalid_1 = Make.new(company: 'Honda', company_motto: 'good products come from clean workplaces')
    invalid_2 = Make.new(ceo_statement: 'Hello', company_motto: 'good products come from clean workplaces')
    valid_make = Make.new(company: 'Honda', company_desc: DESC)
    it{is_expected.to validate_presence_of(:company) }
    it{is_expected.to validate_presence_of(:company_desc) }
  end
end
