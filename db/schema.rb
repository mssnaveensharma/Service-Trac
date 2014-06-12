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

ActiveRecord::Schema.define(version: 20140612055006) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_companies", force: true do |t|
    t.string   "CompanyName"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_eobr_makes", force: true do |t|
    t.string   "Name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_eobr_models", force: true do |t|
    t.string   "Name"
    t.integer  "EobrMake_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_eobr_models", ["EobrMake_id"], name: "index_admin_eobr_models_on_EobrMake_id", using: :btree

  create_table "admin_service_centers", force: true do |t|
    t.string   "Name"
    t.string   "State"
    t.string   "City"
    t.string   "Pin"
    t.string   "Tel"
    t.string   "Fax"
    t.string   "Email"
    t.string   "Url"
    t.string   "ContactPerson"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "lat"
    t.string   "lan"
    t.string   "StateCode"
    t.string   "StreetAddress"
  end

  create_table "admin_tech_supports", force: true do |t|
    t.string   "SupportDescription"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "FromUserId"
    t.integer  "ToUserId"
    t.text     "MessageContent"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sent_by"
    t.integer  "service_center_id"
  end

  create_table "service_alerts", force: true do |t|
    t.integer  "user_id"
    t.integer  "service_center_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "lan"
    t.string   "Status"
    t.string   "lat"
    t.string   "asstimate_time"
    t.string   "asstimate_date"
    t.string   "ticket_po_no"
    t.string   "ticket_ref_no"
  end

  create_table "service_center_reviews", force: true do |t|
    t.integer  "user_id"
    t.string   "comments"
    t.integer  "service_center_id"
    t.integer  "ratings"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "EobrNumber"
    t.integer  "eobr_model_id"
    t.integer  "eobr_make_id"
    t.integer  "tech_support_id"
    t.string   "TruckMake"
    t.string   "company_id"
    t.string   "TruckNumber"
    t.string   "TruckYear"
    t.string   "TruckOwner"
    t.string   "FirstName"
    t.string   "LastName"
    t.string   "Role"
    t.string   "Language"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "lat"
    t.string   "lan"
    t.string   "Contact"
    t.string   "password_salt"
    t.string   "password_hash"
    t.string   "device_type"
    t.string   "device_token"
    t.string   "wp_notification_url"
    t.string   "TruckModel"
    t.string   "plain_password"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_service_centers", force: true do |t|
    t.integer  "user_id"
    t.integer  "service_center_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
