require 'rails_helper'
require 'database_cleaner'

describe 'makes_api' do
  before(:each) do
    3.times do |i|
      Make.create(company: "Company#{i}", company_desc: "company description #{i}")
    end
  end
  it 'returns a list of makes' do
    get '/api/v1/makes'

    expect(response).to be_success
    makes = JSON.parse(response.body)
    expect(makes.count).to eq(3)
  end

  it 'returns a make based on its id' do
    make = Make.last
    id = make.id
    company = make.company

    get "/api/v1/makes/#{id}"

    assert_response :success
    make = JSON.parse(response.body)
    expect(make["id"]).to eq(id)
    expect(make["company"]).to eq(company)
  end

end
