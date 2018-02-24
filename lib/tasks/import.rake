require_relative '../../app/helpers/seed_manager'
require_relative '..//option_list'
require 'faker'
require 'database_cleaner'

task import: :environment do
  s = SeedManager.new
  makes = s.makes_data
  models = s.models_data
  years = s.years_data

  7268.times do |i|
    make_last = Make.last
    make = Make.find_or_create_by(company: makes.shift,
                        company_desc: Faker::Company.bs,
                        company_motto: Faker::Company.catch_phrase,
                        ceo_statement: Faker::SiliconValley.quote
                        )
    make ? make = make_last : nil
    year = Year.find_or_create_by(year: years.shift)
    model_last = Model.last
    model = Model.find_or_create_by(name: models.shift, year_id: year.id, make_id: make.id)
    model ? model = model_last : nil
    Vehicle.create(make_id: make.id, model_id: model.id, vin: Faker::Vehicle.vin)
  end

  200.times do |n|
    (n/6) == 0 ? num = 20 : num = n/6
    model = Model.find(num)
    op_last = Option.last
    option = Option.find_or_create_by(name: OPTIONS.sample,
                        description: Faker::Lorem.sentences,
                        price: (Faker::Commerce.price*10),
                        promotion_code: Faker::Commerce.promotion_code,
                        model_id: model.id)
    option ? option = op_last : nil
    v = Vehicle.find(num)
    v.options << option
  end
end
