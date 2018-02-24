require 'rails_helper'
require 'database_cleaner'

describe 'models_api' do
  before(:each) do
    m = Make.create(company: "Honda", company_desc: "company description")
    y = Year.create(year: 1995)
    3.times do |i|
      Model.create(name: "Model#{i}", year_id: y.id, make_id: m.id)
    end
  end
  it 'returns a list of makes' do
    get '/api/v1/models'

    expect(response).to be_success
    models = JSON.parse(response.body)
    expect(models.count).to eq(3)
  end

  it 'returns a make based on its id' do
    model = Model.last
    id = model.id
    name = model.name

    get "/api/v1/models/#{id}"

    assert_response :success
    model = JSON.parse(response.body)
    expect(model["id"]).to eq(id)
    expect(model["name"]).to eq(name)
  end

end
