require_relative '../../app/helpers/seed_manager'
require_relative '../option_list'
require 'faker'
require 'database_cleaner'

task import: :environment do
  seedm = SeedManager.new
  makes = seedm.makes_data
  models = seedm.models_data
  years = seedm.years_data

  puts 'Begginning seed now...'
  7268.times do |i|
    make_last = Make.last
    make = Make.find_or_create_by(company: makes.shift,
                        company_desc: Faker::Company.bs,
                        company_motto: Faker::Company.catch_phrase,
                        ceo_statement: Faker::SiliconValley.quote
                        )
    make.id ? nil : make = make_last
    year = Year.find_or_create_by(year: years.shift)
    model_last = Model.last
    model = Model.find_or_create_by(name: models.shift, year_id: year.id, make_id: make.id)
    model.id ? nil : model = model_last
    i % 5 == 0 ? Vehicle.create(make_id: make.id, model_id: model.id, vin: Faker::Vehicle.vin + "#{i}") : nil
    i % 1000 == 0 ? (puts "still seeding...#{7 - i/1000} cycles left") : nil
  end

  (Vehicle.count).times do |n|
    n == 0 ? next : nil
    (n/6) == 0 ? num = 20 : num = n/6
    model = Model.find(num)
    op_last = Option.last
    option = Option.find_or_create_by(name: OPTIONS.sample,
                        description: Faker::Lorem.sentences,
                        price: (Faker::Commerce.price*10),
                        promotion_code: Faker::Commerce.promotion_code,
                        model_id: model.id)
    option.id ? nil : option = op_last
    v = Vehicle.find(n)
    v.options << option
    n % 50 == 0 ? (puts "decking our vehicles with options...") : nil
  end
  puts 'Finished seeding databases, ready to rock!'
end
