require 'rails_helper'
require 'database_cleaner'
require_relative './honda_description'

RSpec.describe Option, type: :model do
  context 'validations' do
    it{is_expected.to validate_presence_of(:name)}
    it{is_expected.to validate_presence_of(:description)}
    it{is_expected.to validate_presence_of(:price)}

    it{should belong_to(:model)}

    it "is created with valid attributes" do
    make = Make.create(company: 'Honda', company_desc: DESC)
    year = Year.create(year: 2009)
    model = Model.create(name: 'Civic', make_id: make.id, year_id: year.id)
    #saving requires name,
      invalid_2 = Option.new(description: 'bluetooth description', price: 123.99, promotion_code: 'A', model_id: model.id)
    # description,
      invalid_1 = Option.new(name: 'Bluetooth', price: 123.99, promotion_code: 'ABC123', model_id: model.id)
    # price,
      invalid_3 = Option.new(name: 'Bluetooth', description: 'bluetooth description', promotion_code: 'A', model_id: model.id)
    # valid model_id
      invalid_4 = Option.new(name: 'Bluetooth', description: 'hello', price: 123.99, promotion_code: 'ABC123')
    # and price must be a positive integer
      invalid_4 = Option.new(name: 'Bluetooth', description: 'hello', price: 'abc123', promotion_code: 'ABC123', model_id: model.id)
      invalid_5 = Option.new(name: 'Bluetooth', description: 'hello', price: 0.0, promotion_code: 'ABC123', model_id: model.id)

      expect(invalid_1.class).to eq(Option)
      expect(invalid_1.save).to be false
      expect(invalid_2.save).to be false
      expect(invalid_3.save).to be false

    # invalid price results in automatic fail save
      expect(invalid_4.save).to be false
      expect(invalid_5.save).to be false

    # valid with or without promo-code
      valid_1 = Option.new(name: 'Bluetooth1', description: 'bluetooth description', price: 123.99, promotion_code: 'ABC123', model_id: model.id)
      valid_2 = Option.new(name: 'Bluetooth2', description: 'bluetooth description', price: 123.99, model_id: model.id)

      expect(valid_1.save).to be true
      expect(valid_2.save).to be true

    end
  end

  context 'associations' do
    it "is can call its make and model" do
      make = Make.create(company: 'Honda', company_desc: DESC)
      year = Year.create(year: 2009)
      model = Model.create(name: 'Civic', make_id: make.id, year_id: year.id)
      option = Option.new(name: 'Bluetooth2', description: 'bluetooth description', price: 123.99, model_id: model.id)

      expect(option.model.class).to be(Model)
      expect(option.model.make.class).to be(Make)
      expect(option.model.name).to eq('Civic')
      expect(option.model.make.company).to eq('Honda')
      expect(option.model.year.year).to eq(2009)
    end
  end
end
