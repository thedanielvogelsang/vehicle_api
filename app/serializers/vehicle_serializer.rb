class VehicleSerializer < ActiveModel::Serializer
  attributes :vehicle, :vin, :id, :year, :make, :model, :options, :price

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
    object.options.to_a.map{|o| o.name}.uniq!
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
