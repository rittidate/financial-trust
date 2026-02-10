# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_02_10_050000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "type", null: false
    t.decimal "balance", precision: 15, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "interest_rate", precision: 5, scale: 4, default: "0.0", null: false
    t.string "name"
    t.index ["type"], name: "index_accounts_on_type"
    t.index ["user_id", "type"], name: "index_accounts_on_user_id_and_type", unique: true
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "ledger_entries", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.decimal "amount", precision: 15, scale: 2, null: false
    t.string "entry_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_ledger_entries_on_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.boolean "admin", default: false, null: false
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "ledger_entries", "accounts"
end
