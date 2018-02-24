require 'rails_helper'
require 'database_cleaner'

describe 'vehicles_api' do
  before(:each) do
    m = Make.create(company: "Honda", company_desc: "company description")
    y = Year.create(year: 1995)
    mod = Model.create(name: "Civic", year_id: y.id, make_id: m.id)
    3.times do |i|
      Vehicle.create(make_id: m.id, model_id: mod.id, vin: i)
    end
  end
  it 'returns a list of makes' do
    get '/api/v1/vehicles'

    expect(response).to be_success
    options = JSON.parse(response.body)
    expect(options.count).to eq(3)
  end

  it 'returns a make based on its id' do
    vehicle_1 = Vehicle.first
    id = vehicle_1.id
    vin = vehicle_1.vin

    get "/api/v1/vehicles/#{id}"

    assert_response :success
    vehicle = JSON.parse(response.body)
    expect(vehicle["id"]).to eq(id)
    expect(vehicle["vin"]).to eq(vin)

  end

end