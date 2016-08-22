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

ActiveRecord::Schema.define(version: 20160821211928) do

  create_table "brands", force: :cascade do |t|
    t.string   "name"
    t.string   "website_url"
    t.string   "logo_url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "colors", force: :cascade do |t|
    t.string   "hex"
    t.integer  "h"
    t.integer  "l"
    t.integer  "s"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "photo_url"
    t.decimal  "price",        precision: 6, scale: 2
    t.integer  "brand_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "direct_link"
    t.string   "application"
    t.integer  "no_of_shades"
    t.string   "product_type"
  end

  add_index "products", ["brand_id"], name: "index_products_on_brand_id"

  create_table "shades", force: :cascade do |t|
    t.string   "name"
    t.string   "finish"
    t.integer  "product_id"
    t.integer  "color_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "hex_color"
  end

  add_index "shades", ["color_id"], name: "index_shades_on_color_id"
  add_index "shades", ["product_id"], name: "index_shades_on_product_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
