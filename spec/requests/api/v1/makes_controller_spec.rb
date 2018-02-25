require 'rails_helper'
require 'database_cleaner'

describe 'makes_api' do
  before(:each) do
    3.times do |i|
      Make.create(company: "Company#{i}", company_desc: "company description #{i}")
    end
  end
  xit 'returns a list of makes' do
    get '/api/v1/makes'

    expect(response).to be_success
    makes = JSON.parse(response.body)
    expect(makes.count).to eq(3)
  end

  xit 'returns a make based on its id' do
    make = Make.last
    id = make.id
    company = make.company

    get "/api/v1/makes/#{id}"

    assert_response :success
    make = JSON.parse(response.body)
    expect(make["id"]).to eq(id)
    expect(make["company"]).to eq(company)
  end
  xit 'can create a make' do
    expect(Make.count).to eq(3)
    post "/api/v1/makes?company=NewCompany&company_desc=lengthy_description&company_motto=We+believe+in+you&ceo_statement=I%20love%20my%20job"

    expect(response).to be_success
    expect(response.status).to eq(201)
    expect(Make.count).to eq(4)

    make = JSON.parse(response.body)
    expect(make['company']).to eq('NewCompany')
    expect(make['company_motto']).to eq('We believe in you')
    expect(make['ceo_statement']).to eq('I love my job')
  end
  xit 'will reject a post with improper params' do
    expect(Make.count).to eq(3)
    post "/api/v1/makes?company=NewCompany"

    expect(response).to_not be_success
    expect(response.status).to eq(400)
    body = JSON.parse(response.body)['error']
    expect(body).to eq('bad-params')
    expect(Make.count).to eq(3)
  end

  it 'can update a make with proper params' do
    make = Make.last
    id = make.id
    expect(make.company).to eq('Company2')

    put "/api/v1/makes/#{id}?company=Detroit%20Rock%20City"

    expect(response).to be_success
    new_make = JSON.parse(response.body)

    expect(new_make["company"]).to eq('Detroit Rock City')
    expect(new_make["id"]).to eq(make.id)
  end
  it 'will reject an improper patch' do
    make = Make.last
    id = make.id
    expect(make.company).to eq('Company2')

    patch "/api/v1/makes/#{id}?name=Detroit%20Rock%20City"

    expect(response).to_not be_success
    error = JSON.parse(response.body)
    expect(error["error"]).to eq('bad-params')
  end
end
