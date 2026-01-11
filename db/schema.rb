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

ActiveRecord::Schema.define(version: 20260111194438) do

  create_table "companies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.string   "name"
    t.text     "address",           limit: 65535
    t.string   "city"
    t.string   "pin"
    t.string   "phone"
    t.string   "email"
    t.string   "gst"
    t.string   "adhaar"
    t.string   "pan"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "customers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.string   "name"
    t.text     "address",    limit: 65535
    t.string   "city"
    t.string   "pin"
    t.string   "phone"
    t.string   "email"
    t.string   "gst"
    t.string   "adhaar"
    t.string   "pan"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "jewellery_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.integer  "metal_id"
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["metal_id"], name: "index_jewellery_categories_on_metal_id", using: :btree
  end

  create_table "metals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.string   "name",                        null: false
    t.string   "base_unit",  default: "gram"
    t.boolean  "active",     default: true
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["name"], name: "index_metals_on_name", unique: true, using: :btree
  end

  create_table "purities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.integer  "metal_id"
    t.string   "name",                                                   null: false
    t.decimal  "purity_percent", precision: 5,  scale: 2
    t.boolean  "active",                                  default: true
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.decimal  "updated_price",  precision: 12, scale: 2
    t.string   "remarks"
    t.index ["metal_id"], name: "index_purities_on_metal_id", using: :btree
  end

  create_table "sale_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.integer "sale_id"
    t.integer "metal_id"
    t.integer "purity_id"
    t.integer "jewellery_category_id"
    t.decimal "weight",                precision: 10, scale: 3
    t.decimal "rate",                  precision: 10, scale: 2
    t.string  "making_type"
    t.decimal "making_value",          precision: 10, scale: 2
    t.decimal "metal_value",           precision: 12, scale: 2
    t.decimal "making_amount",         precision: 12, scale: 2
    t.decimal "total_line_amount",     precision: 12, scale: 2
    t.index ["jewellery_category_id"], name: "index_sale_items_on_jewellery_category_id", using: :btree
    t.index ["metal_id"], name: "index_sale_items_on_metal_id", using: :btree
    t.index ["purity_id"], name: "index_sale_items_on_purity_id", using: :btree
    t.index ["sale_id"], name: "index_sale_items_on_sale_id", using: :btree
  end

  create_table "sales", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.integer "user_id"
    t.date    "sale_date"
    t.decimal "subtotal",     precision: 12, scale: 2, default: "0.0"
    t.decimal "making_total", precision: 12, scale: 2, default: "0.0"
    t.decimal "cgst",         precision: 12, scale: 2, default: "0.0"
    t.decimal "sgst",         precision: 12, scale: 2, default: "0.0"
    t.decimal "total_amount", precision: 12, scale: 2, default: "0.0"
    t.index ["user_id"], name: "index_sales_on_user_id", using: :btree
  end

  create_table "stock_ledgers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.integer  "metal_id"
    t.integer  "purity_id"
    t.integer  "jewellery_category_id"
    t.integer  "user_id"
    t.string   "transaction_type",                                                         null: false
    t.decimal  "weight",                              precision: 10, scale: 3
    t.decimal  "rate",                                precision: 12, scale: 2
    t.decimal  "value",                               precision: 14, scale: 2
    t.string   "referenceable_type"
    t.integer  "referenceable_id"
    t.text     "notes",                 limit: 65535
    t.datetime "created_at",                                                               null: false
    t.datetime "updated_at",                                                               null: false
    t.integer  "unit",                                                         default: 0
    t.index ["jewellery_category_id"], name: "index_stock_ledgers_on_jewellery_category_id", using: :btree
    t.index ["metal_id"], name: "index_stock_ledgers_on_metal_id", using: :btree
    t.index ["purity_id"], name: "index_stock_ledgers_on_purity_id", using: :btree
    t.index ["referenceable_type", "referenceable_id"], name: "index_stock_ledgers_on_referenceable_type_and_referenceable_id", using: :btree
    t.index ["user_id"], name: "index_stock_ledgers_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "jewellery_categories", "metals"
  add_foreign_key "purities", "metals"
  add_foreign_key "sale_items", "jewellery_categories"
  add_foreign_key "sale_items", "metals"
  add_foreign_key "sale_items", "purities"
  add_foreign_key "sale_items", "sales"
  add_foreign_key "sales", "users"
  add_foreign_key "stock_ledgers", "jewellery_categories"
  add_foreign_key "stock_ledgers", "metals"
  add_foreign_key "stock_ledgers", "purities"
  add_foreign_key "stock_ledgers", "users"
end
