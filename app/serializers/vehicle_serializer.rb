class VehicleSerializer < ActiveModel::Serializer
  cache only: [:options, :price, :vin]
  delegate :cache_key, :to => :object

  attributes :vehicle, :id, :year, :make, :model, :options, :price, :vin

  def vehicle
    year.to_s + ' ' + make + ' ' + model + ', ' + condition
  end

  def year
    object.model.year.year
  end

  def make
    object.model.make.company
  end

  def model
    object.model.name
  end

  def options
    object.options.to_a.map{|o| o.name}.uniq
  end

  def condition
     ['Fantastic', 'moderate', 'fair', 'Great', 'good', 'poor', 'knee-jerk'].sample + ' condition'
  end

  def price
    option_pricing = object.options.to_a.map{|o| o.price}.reduce(0){|s, n| s+ n}
    ('%.2f' % (option_pricing + conditional)).insert(0, '$')
  end

  def conditional
    [10000, 11000, 12000, 15000, 20000].sample
  end
end
