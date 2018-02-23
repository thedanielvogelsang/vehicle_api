require 'rails_helper'
require_relative './honda_description'
require 'database_cleaner'

RSpec.describe Model, type: :model do
  context 'validations' do

    it{is_expected.to validate_presence_of(:name) }
    it{should belong_to(:make) }

    it 'is created with valid attributes' do
    # name and make must be present
      make = Make.create(company: 'Honda', company_desc: DESC)
      invalid_1 = Model.new(name: 'Civic')
      invalid_2 = Model.new(make_id: 1)
      valid_model = Model.new(name: 'Civic', make_id: make.id)
      expect(invalid_1.class).to be(Model)
      expect(invalid_1.save).to be false
      expect(invalid_2.save).to be false
      expect(valid_model.save).to be true
      expect(valid_model.make.company).to eq('Honda')

    # name uniqueness
      invalid_3 = Model.new(name: 'Civic', make_id: make.id)
      expect(invalid_3.save).to be false
    end
  end
  context 'associations' do
    it 'can call its make' do
      make = Make.create(company: 'Honda', company_desc: DESC)
      model = Model.create(name: 'Civic', make_id: make.id)

      expect(model.make.class).to be(Make)
      expect(model.make.company_desc).to eql(DESC)
    end
    it "is can call its associated model options" do
      make = Make.create(company: 'Honda', company_desc: DESC)
      model = Model.create(name: 'Civic', make_id: make.id)
      op_1 = Option.create(name: 'Bluetooth', description: 'bluetooth description', price: 200.99, promotion_code: 'ABC123', model_id: model.id)
      op_2 = Option.create(name: 'USB-port', description: 'port description', price: 13.99, model_id: model.id)
      op_3 = Option.create(name: 'V2 upgrade', description: 'cylinder upgrade description', price: 2399.99, model_id: model.id)

      expect(model.options.first.class).to eq(Option)
      expect(model.options.count).to eq(3)
      expect(model.options.second.name).to eq('USB-port')
    end
  end
end
