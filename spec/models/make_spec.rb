require 'rails_helper'
require_relative './honda_description'
require 'database_cleaner'

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
  context 'associations' do
    it 'can call all its associated models' do
      make = Make.create(company: 'Honda', company_desc: DESC)
      year = Year.create(year: 2003)
      model1 = Model.create(name: 'Civic', make_id: make.id, year_id: year.id)
      model2 = Model.create(name: 'Accord', make_id: make.id, year_id: year.id)
      model3 = Model.create(name: 'Vue', make_id: make.id, year_id: year.id)
      expect(make.models.count).to eq(3)
      expect(make.models.first.class).to be(Model)
      expect(make.models.last.name).to eq("Vue")
      expect(make.models.first.year.year).to eq(2003)
    end
  end
end
