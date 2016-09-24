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

ActiveRecord::Schema.define(version: 20160924210624) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string   "name"
    t.string   "website_url"
    t.string   "logo_url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "views"
  end

  create_table "looks", force: :cascade do |t|
    t.string   "name"
    t.string   "image_url"
    t.string   "tags"
    t.string   "artist"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "looks_shades", id: false, force: :cascade do |t|
    t.integer "looks_id"
    t.integer "shades_id"
  end

  add_index "looks_shades", ["looks_id"], name: "index_looks_shades_on_looks_id", using: :btree
  add_index "looks_shades", ["shades_id"], name: "index_looks_shades_on_shades_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "photo_url"
    t.decimal  "price",           precision: 6, scale: 2
    t.integer  "brand_id"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "direct_link"
    t.string   "application"
    t.integer  "no_of_shades"
    t.string   "product_type"
    t.integer  "views"
    t.string   "shades_group"
    t.boolean  "multiple_colors"
  end

  add_index "products", ["brand_id"], name: "index_products_on_brand_id", using: :btree

  create_table "shades", force: :cascade do |t|
    t.string   "name"
    t.string   "finish"
    t.integer  "product_id"
    t.integer  "color_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "hex_color"
    t.integer  "views"
    t.integer  "position"
    t.integer  "h"
    t.integer  "s"
    t.integer  "l"
    t.string   "colors_array"
  end

  add_index "shades", ["product_id"], name: "index_shades_on_product_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "products", "brands"
  add_foreign_key "shades", "products"
end
