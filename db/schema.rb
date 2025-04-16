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

ActiveRecord::Schema[7.1].define(version: 2025_04_14_122828) do
  create_table "contributions", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "group_id", null: false
    t.decimal "amount", precision: 10
    t.datetime "date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_contributions_on_group_id"
    t.index ["user_id"], name: "index_contributions_on_user_id"
  end

  create_table "groups", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.decimal "contribution_amount", precision: 10
    t.decimal "total_amount", precision: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "join_code", null: false
    t.integer "admin_id"
    t.index ["join_code"], name: "index_groups_on_join_code", unique: true
  end

  create_table "histories", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "user_id", null: false
    t.string "action"
    t.datetime "timestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_histories_on_group_id"
    t.index ["user_id"], name: "index_histories_on_user_id"
  end

  create_table "memberships", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "group_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_memberships_on_group_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "transactions", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "user_id", null: false
    t.decimal "amount", precision: 10
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_transactions_on_group_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone"
    t.string "gender"
    t.string "role"
    t.string "password_digest"
    t.bigint "group_id"
  end

  add_foreign_key "contributions", "groups"
  add_foreign_key "contributions", "users"
  add_foreign_key "histories", "groups"
  add_foreign_key "histories", "users"
  add_foreign_key "memberships", "groups"
  add_foreign_key "memberships", "users", on_delete: :cascade
  add_foreign_key "transactions", "groups"
  add_foreign_key "transactions", "users"
end
