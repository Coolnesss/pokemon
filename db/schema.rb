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

ActiveRecord::Schema.define(version: 20150419104856) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account", primary_key: "user_id", force: :cascade do |t|
    t.string   "username",   limit: 50,  null: false
    t.string   "password",   limit: 50,  null: false
    t.string   "email",      limit: 355, null: false
    t.datetime "created_on",             null: false
    t.datetime "last_login"
  end

  add_index "account", ["email"], name: "account_email_key", unique: true, using: :btree
  add_index "account", ["username"], name: "account_username_key", unique: true, using: :btree

  create_table "pokes", primary_key: "poke_id", force: :cascade do |t|
    t.string  "name",   limit: 50, null: false
    t.integer "api_id"
  end

  add_index "pokes", ["name"], name: "pokes_name_key", unique: true, using: :btree

  create_table "user_pokes", primary_key: "user_poke_id", force: :cascade do |t|
    t.integer "user_id"
    t.integer "poke_id"
    t.integer "level"
    t.integer "ev"
  end

  create_table "users", primary_key: "user_id", force: :cascade do |t|
    t.string  "username",        limit: 50,                  null: false
    t.string  "password_digest", limit: 255
    t.boolean "admin",                       default: false
  end

  add_index "users", ["username"], name: "person_username_key", unique: true, using: :btree

  add_foreign_key "user_pokes", "users", primary_key: "user_id", name: "user_pokes_user_id_fkey"
end
