class CreateMakes < ActiveRecord::Migration[5.1]
  def change
    create_table :makes do |t|
      t.string :company
      t.text :company_desc
      t.text :company_motto
      t.text :ceo_statement

      t.timestamps
    end
  end
end
