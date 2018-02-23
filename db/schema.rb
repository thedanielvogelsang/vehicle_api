# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180223163652) do

  create_table "makes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "company"
    t.text "company_desc"
    t.text "company_motto"
    t.text "ceo_statement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicle_faker_data", id: :integer, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "year", null: false, unsigned: true
    t.string "make", limit: 50
    t.string "model", limit: 50, null: false
    t.index ["make"], name: "I_vehicle_faker_data_make"
    t.index ["model"], name: "I_vehicle_faker_data_model"
    t.index ["year", "make", "model"], name: "U_vehicle_faker_data_year_make_model", unique: true
    t.index ["year"], name: "I_vehicle_faker_data_year"
  end

end
