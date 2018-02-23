class CreateOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :options do |t|
      t.string :name
      t.text :description
      t.decimal :price, precision: 7, scale: 2
      t.string :promotion_code
      t.references :model, foreign_key: true

      t.timestamps
    end
  end
end
