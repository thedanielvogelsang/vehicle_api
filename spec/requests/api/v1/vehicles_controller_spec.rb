require 'rails_helper'
require 'database_cleaner'

describe 'vehicles_api' do
  before(:each) do
    m = Make.create(company: "Honda", company_desc: "company description")
    y = Year.create(year: 1995)
    Model.create(name: "Scion", year_id: y.id, make_id: m.id)
    mod = Model.create(name: "Civic", year_id: y.id, make_id: m.id)
    3.times do |i|
      Vehicle.create(make_id: m.id, model_id: mod.id, vin: i)
      Option.create(model_id: mod.id, name: "Cool new option #{i + 1}", description: 'desc', price: 100)
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
  it 'can create a vehicle' do
    expect(Vehicle.count).to eq(3)
    mId = Model.last.id
    maId = Make.last.id
    post "/api/v1/vehicles?model_id=#{mId}&make_id=#{maId}&vin=Ab9kl7"

    expect(response).to be_success
    expect(response.status).to eq(201)
    expect(Vehicle.count).to eq(4)

    vehicle = JSON.parse(response.body)
    expect(vehicle['make']).to eq('Honda')
    expect(vehicle['model']).to eq('Civic')
    expect(vehicle['vin']).to eq('Ab9kl7')
  end
  it 'will reject a post with improper params' do
    expect(Vehicle.count).to eq(3)
    mId = Model.last.id
    post "/api/v1/vehicles?model_id=#{mId}&make_id=abc123&vin=Ab9kl7"

    expect(response).to_not be_success
    expect(response.status).to eq(400)
    body = JSON.parse(response.body)['error']
    expect(body).to eq('bad-params')
    expect(Vehicle.count).to eq(3)
  end
  it 'can create a vehicle with options' do
    expect(Vehicle.count).to eq(3)
    mId = Model.last.id
    maId = Make.last.id
    option1 = Option.last
    option2 = Option.first

    post "/api/v1/vehicles?model_id=#{mId}&make_id=#{maId}&vin=Ab9kl7&options_nums=#{option1.id},#{option2.id}"
    expect(response).to be_success
    expect(response.status).to eq(201)
    expect(Vehicle.count).to eq(4)

    vehicle = JSON.parse(response.body)
    expect(vehicle['make']).to eq('Honda')
    expect(vehicle['model']).to eq('Civic')
    expect(vehicle['vin']).to eq('Ab9kl7')
    expect(vehicle['options']).to eq(["Cool new option 3", "Cool new option 1"])
  end
  it 'can update/edit a vehicle' do
    vehicle = Vehicle.last
    mId = Model.last.id
    newMid = Model.first.id
    maId = Make.last.id
    expect(vehicle.make.id).to eq(maId)
    expect(vehicle.model.name).to eq('Civic')
    expect(vehicle.vin).to eq("2")
    put "/api/v1/vehicles/#{vehicle.id}?model_id=#{newMid}&vin=SOMETHING%20NEW"

    expect(response).to be_success
    expect(response.status).to eq(200)
    expect(Vehicle.count).to eq(3)

    vehicle = JSON.parse(response.body)
    expect(vehicle['make']).to eq('Honda')
    expect(vehicle['model']).to eq('Scion')
    expect(vehicle['vin']).to eq('SOMETHING NEW')
  end
  it 'can update/edit a vehicle and add options' do
    vehicle = Vehicle.last
    mId = Model.last.id
    newMid = Model.first.id
    maId = Make.last.id
    option = Option.last
    expect(vehicle.make.id).to eq(maId)
    expect(vehicle.model.name).to eq('Civic')
    expect(vehicle.vin).to eq("2")
    expect(vehicle.options.count).to eq(0)
    put "/api/v1/vehicles/#{vehicle.id}?model_id=#{newMid}&options_nums=#{option.id}"

    expect(response).to be_success
    expect(response.status).to eq(200)
    expect(Vehicle.count).to eq(3)
    vehicle = JSON.parse(response.body)
    expect(vehicle['make']).to eq('Honda')
    expect(vehicle['model']).to eq('Scion')
    expect(vehicle["options"].count).to eq(1)
    expect(vehicle["options"][0]).to eq("Cool new option 3")

  end
  it 'will reject an update put/patch with improper params' do
    expect(Vehicle.count).to eq(3)
    vehicle = Vehicle.last
    mId = Model.last.id
    put "/api/v1/vehicles/#{vehicle.id}?model_id=#{mId}&make_id=abc123&vin=Ab9kl7"

    expect(response).to_not be_success
    expect(response.status).to eq(400)
    body = JSON.parse(response.body)['error']
    expect(body).to eq('bad-params')
    expect(Vehicle.count).to eq(3)
  end
  it 'can delete a vehicle' do
    expect(Vehicle.count).to eq(3)
    vehicle_del = Vehicle.last.id
    # get "/api/v1/vehicles/#{vehicle_del}"
    # expect(response).to be_success
    delete "/api/v1/vehicles/#{vehicle_del}"

    expect(response).to be_success
    expect(response.status).to eq(204)
    vehicle = Vehicle.last.id

    expect(vehicle_del).to_not eq(vehicle)

    get "/api/v1/vehicles/#{vehicle_del}"
    expect(response).to_not be_success
  end
end
