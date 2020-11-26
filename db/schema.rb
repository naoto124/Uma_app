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

ActiveRecord::Schema.define(version: 20201126130052) do

  create_table "couses", force: :cascade do |t|
    t.integer "couse_id"
    t.string "couse_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "place"
    t.string "stage"
    t.string "distance"
    t.integer "speed", default: 1, null: false
    t.integer "power", default: 1, null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "uma_id"
    t.integer "speed", default: 1, null: false
    t.integer "power", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uma_id"], name: "index_favorites_on_uma_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "races", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "type_distance"
    t.string "condition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "umas", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

end
