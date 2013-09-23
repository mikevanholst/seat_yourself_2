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

ActiveRecord::Schema.define(version: 20130923012141) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_restaurants", id: false, force: true do |t|
    t.integer "category_id",   null: false
    t.integer "restaurant_id", null: false
  end

  add_index "categories_restaurants", ["restaurant_id"], name: "index_categories_restaurants_on_restaurant_id"

  create_table "reservations", force: true do |t|
    t.integer  "party_size"
    t.integer  "user_id"
    t.integer  "restaurant_id"
    t.time     "meal_time"
    t.date     "day"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "restaurants", force: true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "price_range"
    t.string   "neighbourhood"
    t.integer  "seats"
    t.text     "description"
    t.string   "category"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: true do |t|
    t.text     "content"
    t.integer  "votes"
    t.integer  "user_id"
    t.integer  "restaurant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "owner"
    t.string   "password_digest"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
