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

ActiveRecord::Schema.define(version: 20180223181657) do

  create_table "makes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "company"
    t.text "company_desc"
    t.text "company_motto"
    t.text "ceo_statement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "models", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.bigint "make_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["make_id"], name: "index_models_on_make_id"
  end

  create_table "options", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "description"
    t.decimal "price", precision: 7, scale: 2
    t.string "promotion_code"
    t.bigint "model_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["model_id"], name: "index_options_on_model_id"
  end

  create_table "vehicles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "make_id"
    t.bigint "model_id"
    t.bigint "year_id"
    t.bigint "options_id"
    t.string "vin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["make_id"], name: "index_vehicles_on_make_id"
    t.index ["model_id"], name: "index_vehicles_on_model_id"
    t.index ["options_id"], name: "index_vehicles_on_options_id"
    t.index ["year_id"], name: "index_vehicles_on_year_id"
  end

  create_table "years", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "models", "makes"
  add_foreign_key "options", "models"
  add_foreign_key "vehicles", "makes"
  add_foreign_key "vehicles", "models"
  add_foreign_key "vehicles", "options", column: "options_id"
  add_foreign_key "vehicles", "years"
end
