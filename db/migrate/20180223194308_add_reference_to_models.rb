class AddReferenceToModels < ActiveRecord::Migration[5.1]
  def change
    add_reference :models, :year, foreign_key: true
  end
end
