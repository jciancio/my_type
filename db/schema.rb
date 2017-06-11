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

ActiveRecord::Schema.define(version: 20170611011945) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "kairos_profiles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "chin_to_eye_height"
    t.float "eye_width"
    t.float "face_proportion"
    t.float "hispanic"
    t.float "asian"
    t.float "other"
    t.float "white"
    t.float "black"
    t.string "image_url"
  end

  create_table "reaction_data", force: :cascade do |t|
    t.bigint "user_like_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_like_id"], name: "index_reaction_data_on_user_like_id"
  end

  create_table "user_likes", force: :cascade do |t|
    t.integer "like_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.integer "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "premium", default: false
  end

  add_foreign_key "reaction_data", "user_likes"
end
