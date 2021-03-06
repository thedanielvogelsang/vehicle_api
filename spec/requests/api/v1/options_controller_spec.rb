require 'rails_helper'
require 'database_cleaner'

describe 'options_api' do
  before(:each) do
    m = Make.create(company: "Honda", company_desc: "company description")
    y = Year.create(year: 1995)
    mod = Model.create(name: "Civic", year_id: y.id, make_id: m.id)
    3.times do |i|
      Option.create(name: "Bluetooth#{i}", description: 'bluetooth description', price: 123.99 + i, model_id: mod.id)
    end
  end
  it 'returns a list of makes' do
    get '/api/v1/options'

    expect(response).to be_success
    options = JSON.parse(response.body)
    expect(options.count).to eq(3)
  end

  it 'returns a make based on its id' do
    option_f = Option.first
    option_l = Option.last
    id = option_f.id
    name = option_f.name

    get "/api/v1/options/#{id}"

    assert_response :success
    option = JSON.parse(response.body)
    expect(option["id"]).to eq(id)
    expect(option["name"]).to eq(name)

    expect(option["name"]).to_not eq(option_l.name)
  end
  it 'can create an option' do
    expect(Option.count).to eq(3)
    mId = Model.last.id
    make = Model.last.make
    post "/api/v1/options?name=Deep+Bass+Subwoofers&description=ABCS&price=20000&promotion_code=18ck39di50wn&model_id=#{mId}"

    expect(response).to be_success
    expect(response.status).to eq(201)
    expect(Option.count).to eq(4)

    vehicle = JSON.parse(response.body)
    expect(vehicle['name']).to eq('Deep Bass Subwoofers')
    expect(vehicle['description']).to eq('ABCS')
    expect(vehicle['promotion_code']).to eq('18ck39di50wn')
    expect(vehicle['unit_price']).to eq('$20000.00')
    expect(vehicle['available_for']).to eq('Honda, Civic')
  end
  it 'will reject a post with improper params' do
    expect(Option.count).to eq(3)
    mId = Model.last.id
    post "/api/v1/options?model_id=#{mId}&make_id=abc123&vin=Ab9kl7"

    expect(response).to_not be_success
    expect(response.status).to eq(400)
    body = JSON.parse(response.body)['error']
    expect(body).to eq('bad-params')
    expect(Option.count).to eq(3)
  end
  it 'will update a put/patch with proper params' do
    option = Option.last
    patch "/api/v1/options/#{option.id}?description=Something+new+from+marketing"

    new_option = Option.last
    expect(option.id).to eq(new_option.id)
    expect(option.description).to_not eq(new_option.description)
    expect(new_option.description).to eq('Something new from marketing')
  end
  it 'will reject a put/patch with improper params' do
    expect(Option.count).to eq(3)
    id = Option.last.id
    put "/api/v1/options/#{id}?make_id=abc123&vin=Ab9kl7"

    expect(response).to_not be_success
    expect(response.status).to eq(400)
    body = JSON.parse(response.body)['error']
    expect(body).to eq('bad-params')
    expect(Option.count).to eq(3)
  end
  it 'will delete an option with an id' do
    option = Option.last
    id = option.id
    delete "/api/v1/options/#{id}"

    expect(response).to be_success
    expect(response.status).to eq(204)
  end
end
