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

ActiveRecord::Schema.define(version: 20200301191823) do

  create_table "accommodations", force: :cascade do |t|
    t.string   "type_of_accommodation", limit: 255
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.decimal  "cost",                              precision: 7, scale: 2
    t.integer  "adulthood_id",          limit: 4
  end

  add_index "accommodations", ["adulthood_id"], name: "index_accommodations_on_adulthood_id", using: :btree

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.integer  "resource_id",   limit: 4
    t.string   "resource_type", limit: 255
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "adulthoods", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "agencies", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "country",      limit: 255
    t.string   "address",      limit: 255
    t.string   "phone_number", limit: 255
    t.string   "email",        limit: 255
    t.string   "commission",   limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "agency_restrictions", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "agency_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "agency_restrictions", ["agency_id"], name: "index_agency_restrictions_on_agency_id", using: :btree
  add_index "agency_restrictions", ["user_id"], name: "index_agency_restrictions_on_user_id", using: :btree

  create_table "attendances", force: :cascade do |t|
    t.integer  "evaluation_id", limit: 4
    t.datetime "hour"
    t.string   "absent",        limit: 255
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.decimal  "grade",                     precision: 5, scale: 2
    t.decimal  "penalty",                   precision: 5, scale: 2
  end

  add_index "attendances", ["evaluation_id"], name: "index_attendances_on_evaluation_id", using: :btree

  create_table "automatizations", force: :cascade do |t|
    t.string   "description",   limit: 255
    t.date     "date"
    t.string   "letter_grade",  limit: 255
    t.integer  "evaluation_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "automatizations", ["evaluation_id"], name: "index_automatizations_on_evaluation_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "last_name",     limit: 255
    t.string   "email_address", limit: 255
    t.string   "phone_number",  limit: 255
    t.string   "position",      limit: 255
    t.string   "branch",        limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "agency_id",     limit: 4
  end

  add_index "contacts", ["agency_id"], name: "index_contacts_on_agency_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "digital_tests", force: :cascade do |t|
    t.string   "level",         limit: 255
    t.string   "attachment",    limit: 255
    t.integer  "evaluation_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "digital_tests", ["evaluation_id"], name: "index_digital_tests_on_evaluation_id", using: :btree

  create_table "evaluations", force: :cascade do |t|
    t.integer  "student_id",      limit: 4
    t.boolean  "graduate"
    t.decimal  "total_grade",                 precision: 5, scale: 2
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
    t.date     "end_date"
    t.integer  "status",          limit: 4
    t.string   "language",        limit: 255
    t.integer  "study_period_id", limit: 4
    t.boolean  "is_active",                                           default: false
  end

  add_index "evaluations", ["student_id"], name: "index_evaluations_on_student_id", using: :btree
  add_index "evaluations", ["study_period_id"], name: "index_evaluations_on_study_period_id", using: :btree

  create_table "fixed_duration_pro_statements", force: :cascade do |t|
    t.integer  "fixed_duration_program_id", limit: 4
    t.integer  "statement_id",              limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "fixed_duration_pro_statements", ["fixed_duration_program_id"], name: "index_fixed_duration_pro_statements_on_fixed_duration_program_id", using: :btree
  add_index "fixed_duration_pro_statements", ["statement_id"], name: "index_fixed_duration_pro_statements_on_statement_id", using: :btree

  create_table "fixed_duration_pro_students", force: :cascade do |t|
    t.integer  "fixed_duration_program_id", limit: 4
    t.integer  "student_id",                limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "fixed_duration_pro_students", ["fixed_duration_program_id"], name: "index_fixed_duration_pro_students_on_fixed_duration_program_id", using: :btree
  add_index "fixed_duration_pro_students", ["student_id"], name: "index_fixed_duration_pro_students_on_student_id", using: :btree

  create_table "fixed_duration_programs", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.integer  "duration_weeks",     limit: 4
    t.decimal  "cost",                           precision: 7, scale: 2
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.decimal  "total_after_promos",             precision: 8, scale: 2
    t.string   "time_table",         limit: 255
  end

  create_table "fixed_duration_programs_promos", id: false, force: :cascade do |t|
    t.integer "fixed_duration_program_id", limit: 4
    t.integer "promo_id",                  limit: 4
  end

  add_index "fixed_duration_programs_promos", ["fixed_duration_program_id"], name: "fdp_promo", using: :btree
  add_index "fixed_duration_programs_promos", ["promo_id"], name: "index_fixed_duration_programs_promos_on_promo_id", using: :btree

  create_table "hours", force: :cascade do |t|
    t.integer  "number",     limit: 4
    t.integer  "program_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "insurances", force: :cascade do |t|
    t.text     "name",       limit: 65535
    t.decimal  "cost",                     precision: 7, scale: 2
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer  "quantity",       limit: 4
    t.decimal  "price_per_unit",             precision: 7, scale: 2
    t.decimal  "total",                      precision: 8, scale: 2
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "name",           limit: 255
  end

  create_table "notes", force: :cascade do |t|
    t.text     "text",       limit: 65535
    t.integer  "student_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "notes", ["student_id"], name: "index_notes_on_student_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.date     "date"
    t.decimal  "amount",                    precision: 11, scale: 3
    t.integer  "student_id",      limit: 4
    t.integer  "statement_id",    limit: 4
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.integer  "study_period_id", limit: 4
  end

  add_index "payments", ["statement_id"], name: "index_payments_on_statement_id", using: :btree
  add_index "payments", ["student_id"], name: "index_payments_on_student_id", using: :btree
  add_index "payments", ["study_period_id"], name: "index_payments_on_study_period_id", using: :btree

  create_table "placement_fees", force: :cascade do |t|
    t.integer  "quantity",       limit: 4
    t.decimal  "price_per_unit",           precision: 7, scale: 2
    t.decimal  "total",                    precision: 8, scale: 2
    t.integer  "item_id",        limit: 4
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "placement_fees", ["item_id"], name: "index_placement_fees_on_item_id", using: :btree

  create_table "programs", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.decimal  "cost",                         precision: 7, scale: 2
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.integer  "lessons_per_week", limit: 4
    t.string   "time_table",       limit: 255
  end

  create_table "promos", force: :cascade do |t|
    t.text     "description",   limit: 65535
    t.decimal  "number",                      precision: 6, scale: 4
    t.string   "percentage",    limit: 255
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.string   "type_of_promo", limit: 255
    t.date     "valid_until"
  end

  create_table "promos_regions", force: :cascade do |t|
    t.integer "promo_id",  limit: 4
    t.integer "region_id", limit: 4
  end

  add_index "promos_regions", ["promo_id"], name: "index_promos_regions_on_promo_id", using: :btree
  add_index "promos_regions", ["region_id"], name: "index_promos_regions_on_region_id", using: :btree

  create_table "promos_statements", force: :cascade do |t|
    t.integer "promo_id",     limit: 4
    t.integer "statement_id", limit: 4
  end

  add_index "promos_statements", ["promo_id"], name: "index_promos_statements_on_promo_id", using: :btree
  add_index "promos_statements", ["statement_id"], name: "index_promos_statements_on_statement_id", using: :btree

  create_table "promos_students", force: :cascade do |t|
    t.integer "promo_id",   limit: 4
    t.integer "student_id", limit: 4
  end

  add_index "promos_students", ["promo_id"], name: "index_promos_students_on_promo_id", using: :btree
  add_index "promos_students", ["student_id"], name: "index_promos_students_on_student_id", using: :btree

  create_table "promos_study_periods", force: :cascade do |t|
    t.integer  "promo_id",        limit: 4
    t.integer  "study_period_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "promos_study_periods", ["promo_id"], name: "index_promos_study_periods_on_promo_id", using: :btree
  add_index "promos_study_periods", ["study_period_id"], name: "index_promos_study_periods_on_study_period_id", using: :btree

  create_table "quizzes", force: :cascade do |t|
    t.integer  "evaluation_id",    limit: 4
    t.date     "date"
    t.string   "chapter",          limit: 255
    t.string   "letter_grade",     limit: 255
    t.decimal  "grade_percentage",             precision: 5, scale: 2
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
  end

  add_index "quizzes", ["evaluation_id"], name: "index_quizzes_on_evaluation_id", using: :btree

  create_table "regions", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "sharp_and_smarts", force: :cascade do |t|
    t.string   "description",   limit: 255
    t.date     "date"
    t.string   "letter_grade",  limit: 255
    t.integer  "evaluation_id", limit: 4
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "score",         limit: 4
    t.string   "color",         limit: 255
    t.decimal  "daily_score",               precision: 5, scale: 2
  end

  add_index "sharp_and_smarts", ["evaluation_id"], name: "index_sharp_and_smarts_on_evaluation_id", using: :btree

  create_table "special_activities", force: :cascade do |t|
    t.integer  "evaluation_id",      limit: 4
    t.string   "description",        limit: 255
    t.date     "date"
    t.string   "letter_grade",       limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "research_grade",     limit: 255
    t.string   "presentation_grade", limit: 255
    t.string   "written_grade",      limit: 255
  end

  add_index "special_activities", ["evaluation_id"], name: "index_special_activities_on_evaluation_id", using: :btree

  create_table "statement_items", force: :cascade do |t|
    t.integer  "statement_id", limit: 4
    t.integer  "item_id",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "statement_items", ["item_id"], name: "index_statement_items_on_item_id", using: :btree
  add_index "statement_items", ["statement_id"], name: "index_statement_items_on_statement_id", using: :btree

  create_table "statements", force: :cascade do |t|
    t.integer  "student_id",               limit: 4
    t.string   "first_name",               limit: 255
    t.string   "last_name",                limit: 255
    t.string   "nationality",              limit: 255
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "duration_weeks",           limit: 4
    t.string   "phone_number",             limit: 255
    t.string   "email_address",            limit: 255
    t.string   "course_language",          limit: 255
    t.string   "number_of_hours",          limit: 255
    t.decimal  "registration_fee",                     precision: 10
    t.decimal  "placement_fee",                        precision: 10
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.string   "type",                     limit: 255
    t.date     "date_of_validity"
    t.decimal  "total_amount",                         precision: 7,  scale: 2
    t.integer  "program_id",               limit: 4
    t.integer  "week_program_hours",       limit: 4
    t.decimal  "program_cost",                         precision: 7,  scale: 2
    t.integer  "accommodation_id",         limit: 4
    t.integer  "adulthood_id",             limit: 4
    t.decimal  "accommodation_cost",                   precision: 7,  scale: 2
    t.decimal  "program_total",                        precision: 7,  scale: 2
    t.string   "entire_stay_duration",     limit: 255
    t.string   "accommodation_duration",   limit: 255
    t.decimal  "accommodation_total",                  precision: 7,  scale: 2
    t.integer  "region_id",                limit: 4
    t.integer  "agency_id",                limit: 4
    t.decimal  "balance",                              precision: 11, scale: 3
    t.boolean  "previous_balance"
    t.boolean  "show_balance"
    t.boolean  "show_bank_info"
    t.boolean  "show_payments"
    t.integer  "post_rebate_program_cost", limit: 4
    t.integer  "week_program_range",       limit: 4
    t.integer  "raw_program_cost",         limit: 4
    t.boolean  "update_student"
    t.integer  "study_period_id",          limit: 4
    t.integer  "insurance_id",             limit: 4
    t.decimal  "insurance_cost",                       precision: 7,  scale: 2
    t.integer  "insurance_cover_period",   limit: 4
    t.date     "start_date_accommodation"
    t.date     "end_date_accommodation"
    t.date     "start_date_insurance"
    t.date     "end_date_insurance"
  end

  add_index "statements", ["accommodation_id"], name: "index_statements_on_accommodation_id", using: :btree
  add_index "statements", ["adulthood_id"], name: "index_statements_on_adulthood_id", using: :btree
  add_index "statements", ["agency_id"], name: "index_statements_on_agency_id", using: :btree
  add_index "statements", ["insurance_id"], name: "index_statements_on_insurance_id", using: :btree
  add_index "statements", ["program_id"], name: "index_statements_on_program_id", using: :btree
  add_index "statements", ["region_id"], name: "index_statements_on_region_id", using: :btree
  add_index "statements", ["student_id"], name: "index_statements_on_student_id", using: :btree
  add_index "statements", ["study_period_id"], name: "index_statements_on_study_period_id", using: :btree

  create_table "student_items", force: :cascade do |t|
    t.integer  "student_id", limit: 4
    t.integer  "item_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "student_items", ["item_id"], name: "index_student_items_on_item_id", using: :btree
  add_index "student_items", ["student_id"], name: "index_student_items_on_student_id", using: :btree

  create_table "students", force: :cascade do |t|
    t.string   "first_name",           limit: 255
    t.string   "last_name",            limit: 255
    t.date     "date_of_birth"
    t.string   "nationality",          limit: 255
    t.string   "gender",               limit: 255
    t.string   "age",                  limit: 255
    t.string   "phone_number",         limit: 255
    t.string   "email_address",        limit: 255
    t.string   "passport_number",      limit: 255
    t.text     "emergency_contact",    limit: 65535
    t.text     "residential_address",  limit: 65535
    t.text     "address_in_canada",    limit: 65535
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "total_hours",          limit: 4
    t.string   "insurance",            limit: 255
    t.string   "caq",                  limit: 255
    t.string   "study_permit",         limit: 255
    t.string   "visa",                 limit: 255
    t.string   "air_ticket",           limit: 255
    t.string   "airport_transfer",     limit: 255
    t.integer  "adulthood_id",         limit: 4
    t.integer  "region_id",            limit: 4
    t.integer  "agency_id",            limit: 4
    t.string   "status",               limit: 255
    t.string   "image",                limit: 255
    t.integer  "level",                limit: 4,     default: 0, null: false
    t.string   "passport_picture",     limit: 255
    t.string   "certificate_picture",  limit: 255
    t.string   "complete_name",        limit: 255
    t.string   "student_id",           limit: 255
    t.string   "itinerary",            limit: 255
    t.integer  "group",                limit: 4,     default: 0, null: false
    t.string   "student_phone_number", limit: 255
    t.string   "emergency_email",      limit: 255
  end

  add_index "students", ["adulthood_id"], name: "index_students_on_adulthood_id", using: :btree
  add_index "students", ["agency_id"], name: "index_students_on_agency_id", using: :btree
  add_index "students", ["date_of_birth"], name: "index_students_on_date_of_birth", using: :btree
  add_index "students", ["last_name"], name: "index_students_on_last_name", using: :btree
  add_index "students", ["nationality"], name: "index_students_on_nationality", using: :btree
  add_index "students", ["region_id"], name: "index_students_on_region_id", using: :btree

  create_table "study_period_fixed_programs", force: :cascade do |t|
    t.integer  "study_period_id",           limit: 4
    t.integer  "fixed_duration_program_id", limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "study_period_fixed_programs", ["fixed_duration_program_id"], name: "index_study_period_fixed_programs_on_fixed_duration_program_id", using: :btree
  add_index "study_period_fixed_programs", ["study_period_id"], name: "index_study_period_fixed_programs_on_study_period_id", using: :btree

  create_table "study_period_items", force: :cascade do |t|
    t.integer  "study_period_id", limit: 4
    t.integer  "item_id",         limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "study_period_items", ["item_id"], name: "index_study_period_items_on_item_id", using: :btree
  add_index "study_period_items", ["study_period_id"], name: "index_study_period_items_on_study_period_id", using: :btree

  create_table "study_periods", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "duration_weeks",           limit: 4
    t.integer  "week_program_hours",       limit: 4
    t.integer  "total_hours",              limit: 4
    t.integer  "program_id",               limit: 4
    t.string   "total_amount",             limit: 255
    t.string   "balance",                  limit: 255
    t.date     "arrival_date"
    t.string   "certificate_issued",       limit: 255
    t.string   "course_language",          limit: 255
    t.integer  "accommodation_id",         limit: 4
    t.integer  "student_id",               limit: 4
    t.integer  "entire_stay_duration",     limit: 4
    t.integer  "program_cost",             limit: 4
    t.integer  "accommodation_duration",   limit: 4
    t.integer  "week_program_range",       limit: 4
    t.decimal  "program_total",                        precision: 7, scale: 2
    t.decimal  "accommodation_total",                  precision: 7, scale: 2
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.integer  "insurance_id",             limit: 4
    t.decimal  "insurance_cost",                       precision: 7, scale: 2
    t.integer  "insurance_cover_period",   limit: 4
    t.string   "certificate_picture",      limit: 255
    t.date     "start_date_accommodation"
    t.date     "end_date_accommodation"
    t.date     "start_date_insurance"
    t.date     "end_date_insurance"
  end

  add_index "study_periods", ["accommodation_id"], name: "index_study_periods_on_accommodation_id", using: :btree
  add_index "study_periods", ["insurance_id"], name: "index_study_periods_on_insurance_id", using: :btree
  add_index "study_periods", ["program_id"], name: "index_study_periods_on_program_id", using: :btree
  add_index "study_periods", ["student_id"], name: "index_study_periods_on_student_id", using: :btree

  create_table "targets", force: :cascade do |t|
    t.integer  "evaluation_id", limit: 4
    t.string   "description",   limit: 255
    t.date     "date"
    t.string   "letter_grade",  limit: 255
    t.string   "student_input", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "targets", ["evaluation_id"], name: "index_targets_on_evaluation_id", using: :btree

  create_table "tests", force: :cascade do |t|
    t.integer  "evaluation_id",    limit: 4
    t.date     "date"
    t.string   "level",            limit: 255
    t.string   "letter_grade",     limit: 255
    t.decimal  "grade_percentage",             precision: 5, scale: 2
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.string   "attachment",       limit: 255
  end

  add_index "tests", ["evaluation_id"], name: "index_tests_on_evaluation_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.integer  "failed_attempts",        limit: 4,   default: 0,  null: false
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "user_name",              limit: 255
    t.integer  "role",                   limit: 4,   default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "weeks", force: :cascade do |t|
    t.string   "number",     limit: 255
    t.decimal  "cost",                   precision: 7, scale: 2
    t.integer  "program_id", limit: 4
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "weeks", ["program_id"], name: "index_weeks_on_program_id", using: :btree

  add_foreign_key "accommodations", "adulthoods"
  add_foreign_key "agency_restrictions", "agencies"
  add_foreign_key "agency_restrictions", "users"
  add_foreign_key "attendances", "evaluations"
  add_foreign_key "automatizations", "evaluations"
  add_foreign_key "contacts", "agencies"
  add_foreign_key "digital_tests", "evaluations"
  add_foreign_key "evaluations", "students"
  add_foreign_key "evaluations", "study_periods"
  add_foreign_key "fixed_duration_pro_statements", "fixed_duration_programs"
  add_foreign_key "fixed_duration_pro_statements", "statements"
  add_foreign_key "fixed_duration_pro_students", "fixed_duration_programs"
  add_foreign_key "fixed_duration_pro_students", "students"
  add_foreign_key "fixed_duration_programs_promos", "fixed_duration_programs"
  add_foreign_key "fixed_duration_programs_promos", "promos"
  add_foreign_key "notes", "students"
  add_foreign_key "payments", "statements"
  add_foreign_key "payments", "students"
  add_foreign_key "payments", "study_periods"
  add_foreign_key "placement_fees", "items"
  add_foreign_key "promos_regions", "promos"
  add_foreign_key "promos_regions", "regions"
  add_foreign_key "promos_statements", "promos"
  add_foreign_key "promos_statements", "statements"
  add_foreign_key "promos_students", "promos"
  add_foreign_key "promos_students", "students"
  add_foreign_key "promos_study_periods", "promos"
  add_foreign_key "promos_study_periods", "study_periods"
  add_foreign_key "quizzes", "evaluations"
  add_foreign_key "sharp_and_smarts", "evaluations"
  add_foreign_key "special_activities", "evaluations"
  add_foreign_key "statement_items", "items"
  add_foreign_key "statement_items", "statements"
  add_foreign_key "statements", "accommodations"
  add_foreign_key "statements", "adulthoods"
  add_foreign_key "statements", "agencies"
  add_foreign_key "statements", "insurances"
  add_foreign_key "statements", "programs"
  add_foreign_key "statements", "regions"
  add_foreign_key "statements", "students"
  add_foreign_key "statements", "study_periods"
  add_foreign_key "student_items", "items"
  add_foreign_key "student_items", "students"
  add_foreign_key "students", "adulthoods"
  add_foreign_key "students", "agencies"
  add_foreign_key "students", "regions"
  add_foreign_key "study_period_fixed_programs", "fixed_duration_programs"
  add_foreign_key "study_period_fixed_programs", "study_periods"
  add_foreign_key "study_period_items", "items"
  add_foreign_key "study_period_items", "study_periods"
  add_foreign_key "study_periods", "accommodations"
  add_foreign_key "study_periods", "insurances"
  add_foreign_key "study_periods", "programs"
  add_foreign_key "study_periods", "students"
  add_foreign_key "targets", "evaluations"
  add_foreign_key "tests", "evaluations"
  add_foreign_key "weeks", "programs"
end
