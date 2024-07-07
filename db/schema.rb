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

ActiveRecord::Schema[7.1].define(version: 2024_06_30_041426) do
  create_table "bag_items", primary_key: "item_id", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_id"
    t.bigint "shopper_id"
    t.index ["product_id"], name: "index_bag_items_on_product_id"
    t.index ["shopper_id"], name: "index_bag_items_on_shopper_id"
  end

  create_table "customers", primary_key: "customer_id", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "address"
    t.string "phone_number", limit: 20
    t.string "city"
    t.string "postal_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "shopper_id"
    t.index ["shopper_id"], name: "index_customers_on_shopper_id"
  end

  create_table "discounts", primary_key: "discount_id", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "rate"
    t.date "expiry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "merchant_id"
    t.bigint "product_id"
    t.index ["merchant_id"], name: "index_discounts_on_merchant_id"
    t.index ["product_id"], name: "index_discounts_on_product_id"
  end

  create_table "merchants", primary_key: "merchant_id", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.string "avatar_img_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "bank_detail"
  end

  create_table "notifications", primary_key: "notification_id", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "message"
    t.bigint "merchant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "read", default: false
    t.index ["merchant_id"], name: "index_notifications_on_merchant_id"
  end

  create_table "orders", primary_key: "order_id", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "total_items"
    t.integer "total_amount"
    t.string "status"
    t.timestamp "date_created"
    t.bigint "customer_id"
    t.bigint "merchant_id"
    t.string "order_number"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["merchant_id"], name: "index_orders_on_merchant_id"
  end

  create_table "products", primary_key: "product_id", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "price"
    t.string "img_url"
    t.integer "available_stocks"
    t.text "sizes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "merchant_id"
    t.index ["merchant_id"], name: "index_products_on_merchant_id"
  end

  create_table "shoppers", primary_key: "shopper_id", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "email", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bag_items", "products", primary_key: "product_id"
  add_foreign_key "bag_items", "shoppers", primary_key: "shopper_id"
  add_foreign_key "customers", "shoppers", primary_key: "shopper_id"
  add_foreign_key "discounts", "products", primary_key: "product_id"
  add_foreign_key "notifications", "merchants", primary_key: "merchant_id"
  add_foreign_key "orders", "customers", primary_key: "customer_id"
  add_foreign_key "orders", "merchants", primary_key: "merchant_id"
end
