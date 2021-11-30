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

ActiveRecord::Schema.define(version: 2021_11_29_160249) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "budget_items", force: :cascade do |t|
    t.bigint "budget_id", null: false
    t.bigint "subscription_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["budget_id"], name: "index_budget_items_on_budget_id"
    t.index ["subscription_id"], name: "index_budget_items_on_subscription_id"
  end

  create_table "budgets", force: :cascade do |t|
    t.string "name"
    t.integer "price_per_month_cents"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_budgets_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "offers", force: :cascade do |t|
    t.bigint "service_id"
    t.string "name"
    t.integer "price_cents"
    t.string "frequency"
    t.bigint "category_id", null: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "service_name"
    t.index ["category_id"], name: "index_offers_on_category_id"
    t.index ["service_id"], name: "index_offers_on_service_id"
    t.index ["user_id"], name: "index_offers_on_user_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image_url"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "offer_id", null: false
    t.bigint "user_id"
    t.text "additional_info"
    t.integer "price_per_day_cents"
    t.date "renewal_date"
    t.integer "reminder_delay_days"
    t.boolean "is_active", default: true
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image_url"
    t.bigint "budget_item_id"
    t.index ["budget_item_id"], name: "index_subscriptions_on_budget_item_id"
    t.index ["offer_id"], name: "index_subscriptions_on_offer_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "global_budget_cents", default: 0
    t.boolean "admin", default: false
    t.string "provider"
    t.string "uid"
    t.bigint "budget_id"
    t.integer "global_budget", default: 0
    t.index ["budget_id"], name: "index_users_on_budget_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "budget_items", "budgets"
  add_foreign_key "budget_items", "subscriptions"
  add_foreign_key "budgets", "users"
  add_foreign_key "offers", "categories"
  add_foreign_key "offers", "services"
  add_foreign_key "offers", "users"
  add_foreign_key "subscriptions", "budgets", column: "budget_item_id"
  add_foreign_key "subscriptions", "offers"
  add_foreign_key "users", "budgets"
end
