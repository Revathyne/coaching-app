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

ActiveRecord::Schema[7.1].define(version: 2024_06_02_130523) do
  create_table "coach_coaching_programs", force: :cascade do |t|
    t.integer "coach_id", null: false
    t.integer "coaching_program_id", null: false
    t.string "additional_field"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coach_id"], name: "index_coach_coaching_programs_on_coach_id"
    t.index ["coaching_program_id"], name: "index_coach_coaching_programs_on_coaching_program_id"
  end

  create_table "coaches", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_coaches_on_user_id"
  end

  create_table "coaches_coaching_programs", id: false, force: :cascade do |t|
    t.integer "coach_id", null: false
    t.integer "coaching_program_id", null: false
  end

  create_table "coaching_programs", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_coaching_programs_on_company_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.integer "phone"
    t.string "address"
  end

  create_table "employee_registrations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "coaching_program_id", null: false
    t.integer "coach_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "phone"
    t.integer "address"
    t.index ["coach_id"], name: "index_employee_registrations_on_coach_id"
    t.index ["coaching_program_id"], name: "index_employee_registrations_on_coaching_program_id"
    t.index ["user_id", "coaching_program_id", "coach_id"], name: "unique_employee_registration", unique: true
    t.index ["user_id"], name: "index_employee_registrations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "role", default: 0
    t.integer "company_id"
    t.integer "phone"
    t.integer "age"
    t.string "address"
    t.integer "coach_id"
    t.index ["coach_id"], name: "index_users_on_coach_id"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "coach_coaching_programs", "coaches"
  add_foreign_key "coach_coaching_programs", "coaching_programs"
  add_foreign_key "coaches", "users"
  add_foreign_key "coaching_programs", "companies"
  add_foreign_key "employee_registrations", "coaches"
  add_foreign_key "employee_registrations", "coaching_programs"
  add_foreign_key "employee_registrations", "users"
  add_foreign_key "users", "coaches"
  add_foreign_key "users", "companies"
end