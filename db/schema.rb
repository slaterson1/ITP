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

ActiveRecord::Schema.define(version: 20160509161033) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string   "team"
    t.string   "gps_location"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.string   "street_address"
    t.decimal  "low_price"
    t.decimal  "high_price"
    t.decimal  "average_price"
    t.string   "venue_photo"
    t.string   "ticket_url"
    t.datetime "local_datetime"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "pitstop_id"
    t.integer  "game_number"
  end

  create_table "itineraries", force: :cascade do |t|
    t.date     "start_date"
    t.integer  "travel_days"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
  end

  create_table "pitstops", force: :cascade do |t|
    t.string   "city"
    t.integer  "itinerary_id"
    t.date     "date_visited"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first"
    t.string   "last"
    t.string   "password_digest"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "auth_token"
  end

end
