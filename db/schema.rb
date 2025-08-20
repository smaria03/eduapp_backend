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

ActiveRecord::Schema.define(version: 2025_08_20_081453) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "assignment_id", null: false
    t.bigint "period_id", null: false
    t.date "date"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["assignment_id"], name: "index_attendances_on_assignment_id"
    t.index ["period_id"], name: "index_attendances_on_period_id"
    t.index %w[user_id assignment_id period_id date], name: "index_attendances_on_unique_columns", unique: true
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "grades", force: :cascade do |t|
    t.integer "value"
    t.bigint "student_id", null: false
    t.bigint "teacher_id", null: false
    t.bigint "subject_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["student_id"], name: "index_grades_on_student_id"
    t.index ["subject_id"], name: "index_grades_on_subject_id"
    t.index ["teacher_id"], name: "index_grades_on_teacher_id"
  end

  create_table "periods", force: :cascade do |t|
    t.time "start_time"
    t.time "end_time"
    t.string "label"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["start_time", "end_time"], name: "idx_periods_unique_range", unique: true
  end

  create_table "school_class_subjects", force: :cascade do |t|
    t.bigint "school_class_id", null: false
    t.bigint "subject_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "teacher_id"
    t.index ["school_class_id", "subject_id"], name: "idx_unique_class_subject", unique: true
    t.index ["school_class_id", "subject_id"], name: "index_unique_class_subject", unique: true
    t.index ["school_class_id"], name: "index_school_class_subjects_on_school_class_id"
    t.index ["subject_id"], name: "index_school_class_subjects_on_subject_id"
    t.index ["teacher_id"], name: "index_school_class_subjects_on_teacher_id"
  end

  create_table "school_classes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_school_classes_on_name", unique: true
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_subjects_on_name", unique: true
  end

  create_table "timetable_entries", force: :cascade do |t|
    t.bigint "assignment_id", null: false
    t.integer "weekday", null: false
    t.bigint "period_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["assignment_id", "weekday", "period_id"], name: "idx_unique_assignment_day_period", unique: true
    t.index ["assignment_id"], name: "index_timetable_entries_on_assignment_id"
    t.index ["period_id"], name: "index_timetable_entries_on_period_id"
    t.index ["weekday", "period_id"], name: "idx_timetable_day_period"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "jti"
    t.bigint "school_class_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["school_class_id"], name: "index_users_on_school_class_id"
  end

  add_foreign_key "attendances", "periods"
  add_foreign_key "attendances", "school_class_subjects", column: "assignment_id"
  add_foreign_key "attendances", "users"
  add_foreign_key "grades", "subjects"
  add_foreign_key "grades", "users", column: "student_id"
  add_foreign_key "grades", "users", column: "teacher_id"
  add_foreign_key "school_class_subjects", "school_classes"
  add_foreign_key "school_class_subjects", "subjects"
  add_foreign_key "school_class_subjects", "users", column: "teacher_id"
  add_foreign_key "timetable_entries", "periods"
  add_foreign_key "timetable_entries", "school_class_subjects", column: "assignment_id"
  add_foreign_key "users", "school_classes"
end
