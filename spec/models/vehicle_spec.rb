require 'rails_helper'
require 'database_cleaner'
require_relative './honda_description'

RSpec.describe Vehicle, type: :model do
  context 'validations' do
    make = Make.create(company: 'Honda', company_desc: DESC)
    model = Model.create(name: 'Civic', make_id: make.id)
    year = Year.create(year: 2007)
    op_1 = Option.new(name: 'Bluetooth', description: 'bluetooth description', price: 200.99, promotion_code: 'ABC123', model_id: model.id)
    op_2 = Option.new(name: 'USB-port', description: 'port description', price: 13.99, model_id: model.id)
    op_3 = Option.new(name: 'V2 upgrade', description: 'cylinder upgrade description', price: 2399.99, model_id: model.id)
    it "is created with valid attributes" do
    # is created only with make, model, year, vin, and manufacture #
      invalid_1 = Vehicle.new(make_id: make.id, model_id: model.id, year: year.id, vin: "LLDWXZLG77VK2LUUF")
      invalid_2 = Vehicle.new(make_id: make.id, model_id: model.id, year: year.id, vin: "LLDWXZLG77VK2LUUF")
      invalid_3 = Vehicle.new(make_id: make.id, model_id: model.id, year: year.id, vin: "LLDWXZLG77VK2LUUF")
      invalid_4 = Vehicle.new(make_id: make.id, model_id: model.id, year: year.id, vin: "LLDWXZLG77VK2LUUF")

      expect(invalid_1.save).to be false
      expect(invalid_2.save).to be false
      expect(invalid_3.save).to be false
      expect(invalid_4.save).to be false
    # may be created with or without options
      valid_with = Vehicle.new(make_id: make.id, model_id: model.id, year: year.id, vin: "LLDWXZLG77VK2LUUF")
      valid_without = Vehicle.new(make_id: make.id, model_id: model.id, year: year.id, vin: "LLDWXZLG77VK2LUUF")
      valid_with.options << {op_2 op_3}

      expect(valid_with.save).to be true
      expect(valid_without.save).to be true
    end
  end
  context 'associations' do
    it{should have_many{:options}}
    it{is_expected.to belong_to{:make}}
    it{is_expected.to belong_to{:model}}
    it{is_expected.to belong_to{:year}}
  end
end
