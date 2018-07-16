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

ActiveRecord::Schema.define(version: 20180429025507) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.string "cardable_type"
    t.bigint "cardable_id"
    t.string "suit"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cardable_type", "cardable_id"], name: "index_cards_on_cardable_type_and_cardable_id"
  end

  create_table "communities", force: :cascade do |t|
    t.string "aasm_state"
    t.integer "game_id"
    t.integer "pod", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "holes", force: :cascade do |t|
    t.integer "player_id"
    t.integer "community_id"
    t.integer "hand"
    t.string "aasm_state"
    t.boolean "out_come", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "password"
    t.integer "game_id"
    t.integer "chip", default: 500
    t.integer "role", default: 3
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
