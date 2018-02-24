class RemoveColumnFromVehicles < ActiveRecord::Migration[5.1]
  def change
    remove_reference :vehicles, :options, foreign_key: true
  end
end
