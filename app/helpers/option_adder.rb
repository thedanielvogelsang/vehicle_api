class OptionAdder

  def initialize(options)
    vehicle = Vehicle.last
    options.split(',').each{ |o| vehicle.options << Option.find(o.to_i)}
  end
end
