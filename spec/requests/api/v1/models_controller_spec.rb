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
  it 'can create a model' do
    expect(Model.count).to eq(3)
    mId = Make.last.id
    yId = Year.last.id
    post "/api/v1/models?name=Civic%20Duty&make_id=#{mId}&year_id=#{yId}"

    expect(response).to be_success
    expect(response.status).to eq(201)
    expect(Model.count).to eq(4)

    model = JSON.parse(response.body)
    expect(model['name']).to eq('Civic Duty')
    expect(model['manufacturer']).to eq('Honda')
    expect(model['year']).to eq(1995)
  end
  it 'will reject a post with improper params' do
    expect(Model.count).to eq(3)
    post "/api/v1/models?company=NewCompany"

    expect(response).to_not be_success
    expect(response.status).to eq(400)
    body = JSON.parse(response.body)['error']
    expect(body).to eq('bad-params')
    expect(Model.count).to eq(3)
  end
  it 'can update/edit a model with correct params' do
    model = Model.last
    put "/api/v1/models/#{model.id}?name=NewName"

    expect(response).to be_success
    expect(response.status).to eq(200)

    model_update = JSON.parse(response.body)
    expect(model_update["id"]).to eq(model.id)
  end
  it 'will reject a put/patch with improper params' do
    expect(Model.count).to eq(3)
    patch "/api/v1/models/#{Model.last.id}?name=Model1"

    expect(response).to_not be_success
    expect(response.status).to eq(400)
    body = JSON.parse(response.body)['error']
    expect(body).to eq('bad-params')
    expect(Model.count).to eq(3)
  end
end
