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

end
