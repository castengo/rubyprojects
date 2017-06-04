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

ActiveRecord::Schema.define(version: 20161108003104) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "brands", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "website_url"
    t.string "logo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "views"
  end

  create_table "looks", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "caption"
    t.string "image_url"
    t.string "tags"
    t.integer "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_looks_on_profile_id"
  end

  create_table "products", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "photo_url"
    t.decimal "price", precision: 6, scale: 2
    t.integer "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "direct_link"
    t.string "application"
    t.integer "no_of_shades"
    t.string "product_type"
    t.integer "views"
    t.string "shades_group"
    t.boolean "multiple_colors"
    t.string "short_type"
    t.index ["brand_id"], name: "index_products_on_brand_id"
  end

  create_table "profiles", id: :serial, force: :cascade do |t|
    t.string "about"
    t.string "avatar_url"
    t.string "website_url"
    t.string "instagram_url"
    t.string "youtube_url"
    t.string "facebook_url"
    t.string "twitter_url"
    t.integer "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_profiles_on_account_id"
  end

  create_table "shades", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "finish"
    t.integer "product_id"
    t.integer "color_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "hex_color"
    t.integer "views"
    t.integer "position"
    t.integer "h"
    t.integer "s"
    t.integer "l"
    t.string "colors_array"
    t.index ["product_id"], name: "index_shades_on_product_id"
  end

  create_table "tutorials", id: :serial, force: :cascade do |t|
    t.integer "shade_id"
    t.integer "look_id"
    t.index ["look_id"], name: "index_tutorials_on_look_id"
    t.index ["shade_id"], name: "index_tutorials_on_shade_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "looks", "profiles"
  add_foreign_key "products", "brands"
  add_foreign_key "profiles", "accounts"
  add_foreign_key "shades", "products"
end
