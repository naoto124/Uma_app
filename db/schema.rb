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

ActiveRecord::Schema.define(version: 20210207054455) do

  create_table "couse_parameters", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "couse_id"
    t.float "speed", limit: 24, default: 1.0, null: false
    t.float "power", limit: 24, default: 1.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["couse_id"], name: "index_couse_parameters_on_couse_id"
    t.index ["user_id"], name: "index_couse_parameters_on_user_id"
  end

  create_table "couses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "couse_id"
    t.string "couse_name"
    t.string "place"
    t.string "stage"
    t.string "distance"
    t.integer "speed", default: 1, null: false
    t.integer "power", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "uma_id"
    t.integer "speed", default: 1, null: false
    t.integer "power", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uma_id"], name: "index_favorites_on_uma_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "myraces", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "race_id"
    t.integer "code"
    t.float "speed", limit: 24, default: 1.0, null: false
    t.float "power", limit: 24, default: 1.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["race_id"], name: "index_myraces_on_race_id"
    t.index ["user_id"], name: "index_myraces_on_user_id"
  end

  create_table "races", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "umas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "couse_parameters", "couses"
  add_foreign_key "couse_parameters", "users"
  add_foreign_key "favorites", "umas"
  add_foreign_key "favorites", "users"
  add_foreign_key "myraces", "races"
  add_foreign_key "myraces", "users"
end
