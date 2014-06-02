# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140602110335) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "electronics", force: true do |t|
    t.integer  "s_no"
    t.string   "make"
    t.string   "model"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_center_reviews", force: true do |t|
    t.integer  "user_id"
    t.string   "comments"
    t.integer  "service_center_id"
    t.integer  "ratings"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_centers", force: true do |t|
    t.string   "name"
    t.string   "city"
    t.string   "state"
    t.integer  "pin"
    t.integer  "telephone"
    t.integer  "fax"
    t.string   "email"
    t.string   "url"
    t.string   "contact_person"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.integer  "e_no"
    t.string   "e_make"
    t.string   "e_model"
    t.integer  "truck_number"
    t.string   "truck_make"
    t.date     "truck_year"
    t.integer  "truck_owner"
    t.string   "company_name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "language"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vehicle_locations", force: true do |t|
    t.integer  "user_id"
    t.integer  "latitude"
    t.integer  "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
