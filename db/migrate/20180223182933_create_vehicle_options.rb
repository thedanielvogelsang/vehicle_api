class CreateVehicleOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicle_options do |t|
      t.references :vehicle, foreign_key: true
      t.references :option, foreign_key: true

      t.timestamps
    end
  end
end
