ActiveRecord::Base.establish_connection(
:adapter => "mysql2",
:host => "localhost",
:database => "vehicle_api_development",
:username => 'dvog_temp',
:password => "Blink3r!"
)

class SeedManager
  def makes_data
    sql = 'SELECT make FROM vehicle_faker_data;'
    makes_array = ActiveRecord::Base.connection.select_all(sql)
    makes_array.map{|m| m["make"]}
  end

  def models_data
    sql = 'SELECT model FROM vehicle_faker_data;'
    models_array = ActiveRecord::Base.connection.select_all(sql)
    models_array.map{|m| m["model"]}
  end

  def years_data
    sql = 'SELECT year FROM vehicle_faker_data;'
    years_array = ActiveRecord::Base.connection.select_all(sql)
    years_array.map{|y| y["year"]}
  end

end
