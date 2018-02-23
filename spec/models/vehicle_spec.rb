require 'rails_helper'
require 'database_cleaner'
require_relative './honda_description'

RSpec.describe Vehicle, type: :model do
  before(:each) do
    @make = Make.create(company: 'Honda', company_desc: DESC)
    year = Year.create(year: 2007)
    @model = Model.create(name: 'Civic', make_id: @make.id, year_id: year.id)
    @op_1 = Option.create(name: 'Bluetooth', description: 'bluetooth description', price: 200.99, promotion_code: 'ABC123', model_id: @model.id)
    @op_2 = Option.create(name: 'USB-port', description: 'port description', price: 13.99, model_id: @model.id)
    @op_3 = Option.create(name: 'V2 upgrade', description: 'cylinder upgrade description', price: 2399.99, model_id: @model.id)
  end

  context 'validations' do
    it{is_expected.to validate_presence_of(:make_id)}
    it{is_expected.to validate_presence_of(:model_id)}
    it{is_expected.to validate_presence_of(:vin)}

    it "is created with valid attributes" do
    # is created only with make, model, year, vin #
      invalid_1 = Vehicle.new(model_id: @model.id, vin: "LLDWXZLG77VK2LUUF")
      invalid_2 = Vehicle.new(make_id: @make.id, vin: "LLDWXZLG77VK2LUUF")
      invalid_4 = Vehicle.new(make_id: @make.id, model_id: @model.id)
      expect(invalid_1.save).to be false
      expect(invalid_2.save).to be false
      expect(invalid_4.save).to be false

    # vin numbers must be different
      valid = Vehicle.new(make_id: @make.id, model_id: @model.id, vin: "LLDWXZLG77VK2LUUF")
      invalid_5 = Vehicle.new(make_id: @make.id, model_id: @model.id, vin: "LLDWXZLG77VK2LUUF")
      expect(valid.save).to be true
      expect(invalid_5.save).to be false

    end
  end
  context 'associations' do

    it{should have_many(:vehicle_options)}
    it{should have_many(:options).through(:vehicle_options)}
    it{is_expected.to belong_to(:make)}
    it{is_expected.to belong_to(:model)}

    it 'should be able to call its make, model, and year' do
      vehicle = Vehicle.new(make_id: @make.id, model_id: @model.id, vin: "LLDWXZLG77VK2LUUF")

      expect(vehicle.make.class).to be(Make)
      expect(vehicle.make.company).to eq('Honda')
      expect(vehicle.model.class).to be(Model)
      expect(vehicle.model.name).to eq('Civic')
      expect(vehicle.model.year.year).to eq(2007)
    end

    it "should be able to collect many options or have none" do
      vehicle_1 = Vehicle.new(make_id: @make.id, model_id: @model.id, vin: "LLDWXZLG77VK2LUUF")
      vehicle_2 = Vehicle.new(make_id: @make.id, model_id: @model.id, vin: "SOMETHING DIFFERENT")
      vehicle_1.options << @op_2
      vehicle_1.save
      vehicle_2.options << @op_1
      vehicle_2.options << @op_2
      vehicle_2.options << @op_3
      vehicle_2.save

      expect(vehicle_1.options.count).to eq(1)
      expect(vehicle_1.options.first.name).to eq('USB-port')
      expect(vehicle_2.options.count).to eq(3)
      expect(vehicle_2.options.last.name).to eq('V2 upgrade')
      byebug
    end
  end
end
