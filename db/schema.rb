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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100913073138) do

  create_table "accounts", :force => true do |t|
    t.string   "name",                                                           :null => false
    t.string   "account_type",                                                   :null => false
    t.decimal  "monthly_charge", :precision => 8, :scale => 2, :default => 0.0,  :null => false
    t.boolean  "active",                                       :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "address_types", :force => true do |t|
    t.string "name",        :limit => 64
    t.string "description"
  end

  create_table "addresses", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "addressable_type"
    t.integer  "addressable_id"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.integer  "state_id"
    t.string   "state_name"
    t.string   "zip_code"
    t.string   "alternative_phone"
    t.boolean  "default",           :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "billing_default",   :default => false
    t.boolean  "active",            :default => true
  end

  create_table "batches", :force => true do |t|
    t.string   "batchable_type"
    t.integer  "batchable_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "batches", ["batchable_id"], :name => "index_batches_on_batchable_id"
  add_index "batches", ["batchable_type"], :name => "index_batches_on_batchable_type"

  create_table "brands", :force => true do |t|
    t.string "name"
  end

  create_table "cart_items", :force => true do |t|
    t.integer  "cart_id"
    t.integer  "variant_id",                     :null => false
    t.boolean  "active",       :default => true
    t.integer  "item_type_id",                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity",     :default => 1
    t.integer  "user_id"
  end

  add_index "cart_items", ["item_type_id"], :name => "index_carts_on_item_type_id"
  add_index "cart_items", ["variant_id"], :name => "index_carts_on_variant_id"

  create_table "carts", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", :force => true do |t|
    t.string "name"
    t.string "abbreviation", :limit => 5
  end

  create_table "images", :force => true do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.integer  "image_height"
    t.integer  "image_width"
    t.integer  "position"
    t.string   "caption"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "invoices", :force => true do |t|
    t.integer  "order_id",                                                   :null => false
    t.string   "number",                                                     :null => false
    t.decimal  "amount",     :precision => 8, :scale => 2,                   :null => false
    t.string   "state",                                                      :null => false
    t.boolean  "active",                                   :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invoices", ["order_id"], :name => "index_invoices_on_order_id"

  create_table "item_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_items", :force => true do |t|
    t.decimal  "price",            :precision => 8, :scale => 2
    t.decimal  "total",            :precision => 8, :scale => 2
    t.integer  "order_id"
    t.integer  "variant_id"
    t.string   "state"
    t.integer  "tax_rate_id"
    t.integer  "shipping_rate_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.string   "number"
    t.string   "ip_address"
    t.string   "email"
    t.string   "state"
    t.integer  "user_id"
    t.integer  "bill_address_id"
    t.integer  "ship_address_id"
    t.integer  "coupon_id"
    t.boolean  "active",          :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "calculated_at"
    t.datetime "completed_at"
  end

  create_table "payment_profiles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "address_id"
    t.string   "payment_cim_id"
    t.boolean  "default"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payment_profiles", ["user_id"], :name => "index_payment_profiles_on_user_id"

  create_table "payments", :force => true do |t|
    t.integer  "invoice_id"
    t.string   "confirmation_id"
    t.integer  "amount"
    t.string   "error"
    t.string   "error_code"
    t.string   "message"
    t.string   "action"
    t.text     "params"
    t.boolean  "success"
    t.boolean  "test"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments", ["invoice_id"], :name => "index_payments_on_invoice_id"

  create_table "phone_types", :force => true do |t|
    t.string "name", :null => false
  end

  create_table "phones", :force => true do |t|
    t.integer  "phone_type_id"
    t.string   "number",                            :null => false
    t.string   "phoneable_type",                    :null => false
    t.integer  "phoneable_id",                      :null => false
    t.boolean  "primary",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_properties", :force => true do |t|
    t.integer "product_id"
    t.integer "property_id"
    t.integer "position"
    t.string  "description"
  end

  create_table "product_types", :force => true do |t|
    t.string  "name"
    t.integer "parent_id"
    t.boolean "active",    :default => true, :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "product_type_id"
    t.integer  "tax_status_id",                           :null => false
    t.datetime "available_at"
    t.datetime "deleted_at"
    t.string   "meta_keywords"
    t.string   "meta_description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "prototype_id"
    t.boolean  "featured",             :default => false
    t.string   "permalink",                               :null => false
    t.integer  "shipping_category_id",                    :null => false
  end

  create_table "properties", :force => true do |t|
    t.string  "identifing_name"
    t.string  "display_name"
    t.boolean "active"
  end

  create_table "prototype_properties", :force => true do |t|
    t.integer "prototype_id"
    t.integer "property_id"
  end

  create_table "prototypes", :force => true do |t|
    t.string  "name"
    t.boolean "active"
  end

  create_table "purchase_order_variants", :force => true do |t|
    t.integer  "purchase_order_id",                                                   :null => false
    t.integer  "variant_id",                                                          :null => false
    t.integer  "quantity",                                                            :null => false
    t.decimal  "cost",              :precision => 10, :scale => 0,                    :null => false
    t.boolean  "is_received",                                      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchase_orders", :force => true do |t|
    t.integer  "supplier_id",          :null => false
    t.string   "invoice_number"
    t.string   "tracking_number"
    t.string   "notes"
    t.string   "state"
    t.datetime "ordered_at",           :null => false
    t.date     "estimated_arrival_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string "name", :limit => 30
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "shipments", :force => true do |t|
    t.integer  "order_id"
    t.integer  "shipping_method_id",                   :null => false
    t.integer  "address_id",                           :null => false
    t.string   "tracking"
    t.string   "number",                               :null => false
    t.string   "state",                                :null => false
    t.datetime "shipped_at"
    t.boolean  "active",             :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shipments", ["address_id"], :name => "index_shipments_on_address_id"
  add_index "shipments", ["order_id"], :name => "index_shipments_on_order_id"
  add_index "shipments", ["shipping_method_id"], :name => "index_shipments_on_shipping_method_id"

  create_table "shipping_categories", :force => true do |t|
    t.string  "name",       :null => false
    t.integer "product_id", :null => false
  end

  create_table "shipping_methods", :force => true do |t|
    t.string   "name"
    t.integer  "shipping_zone_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shipping_rate_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shipping_rates", :force => true do |t|
    t.integer  "shipping_method_id",                                  :null => false
    t.decimal  "rate",                  :precision => 8, :scale => 2, :null => false
    t.integer  "shipping_rate_type_id",                               :null => false
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "minimum_charge",        :precision => 8, :scale => 2, :null => false
    t.integer  "shipping_category_id",                                :null => false
  end

  create_table "shipping_zones", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "states", :force => true do |t|
    t.string  "name"
    t.string  "abbreviation",     :limit => 5
    t.string  "described_as"
    t.integer "country_id"
    t.integer "shipping_zone_id",              :default => 1
  end

  add_index "states", ["abbreviation"], :name => "index_states_on_abbreviation"
  add_index "states", ["country_id"], :name => "index_states_on_country_id"

  create_table "suppliers", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tax_rates", :force => true do |t|
    t.decimal "percentage",    :precision => 8, :scale => 2,                   :null => false
    t.integer "tax_status_id",                                                 :null => false
    t.integer "state_id",                                                      :null => false
    t.date    "start_date",                                                    :null => false
    t.date    "end_date"
    t.boolean "active",                                      :default => true
  end

  add_index "tax_rates", ["state_id"], :name => "index_tax_rates_on_state_id"
  add_index "tax_rates", ["tax_status_id"], :name => "index_tax_rates_on_product_type_id"

  create_table "tax_statuses", :force => true do |t|
    t.string "name", :null => false
  end

  create_table "transaction_accounts", :force => true do |t|
    t.string   "type"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transaction_ledgers", :force => true do |t|
    t.string   "accountable_type"
    t.integer  "accountable_id"
    t.integer  "transaction_id"
    t.integer  "transaction_account_id"
    t.decimal  "debit",                  :precision => 8, :scale => 2, :null => false
    t.decimal  "credit",                 :precision => 8, :scale => 2, :null => false
    t.string   "period"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transaction_ledgers", ["accountable_id"], :name => "index_transaction_ledgers_on_accountable_id"
  add_index "transaction_ledgers", ["transaction_account_id"], :name => "index_transaction_ledgers_on_transaction_account_id"
  add_index "transaction_ledgers", ["transaction_id"], :name => "index_transaction_ledgers_on_transaction_id"

  create_table "transactions", :force => true do |t|
    t.string   "type"
    t.integer  "batch_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transactions", ["batch_id"], :name => "index_transactions_on_batch_id"

  create_table "user_roles", :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birth_date"
    t.string   "email"
    t.string   "state"
    t.integer  "account_id"
    t.string   "customer_cim_id"
    t.string   "password_salt"
    t.string   "crypted_password"
    t.string   "access_token",      :limit => 64, :null => false
    t.string   "perishable_token"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["first_name"], :name => "index_users_on_first_name"
  add_index "users", ["last_name"], :name => "index_users_on_last_name"

  create_table "variant_properties", :force => true do |t|
    t.integer "variant_id"
    t.integer "property_id"
    t.string  "description"
  end

  create_table "variant_suppliers", :force => true do |t|
    t.integer  "variant_id",                                                               :null => false
    t.integer  "supplier_id",                                                              :null => false
    t.decimal  "cost",                    :precision => 8, :scale => 2, :default => 0.0,   :null => false
    t.integer  "total_quantity_supplied",                               :default => 0
    t.integer  "min_quantity",                                          :default => 1
    t.integer  "max_quantity",                                          :default => 10000
    t.boolean  "active",                                                :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "variants", :force => true do |t|
    t.integer  "product_id"
    t.string   "sku"
    t.decimal  "price",                       :precision => 8, :scale => 2, :default => 0.0,   :null => false
    t.decimal  "cost",                        :precision => 8, :scale => 2, :default => 0.0,   :null => false
    t.datetime "deleted_at"
    t.boolean  "master",                                                    :default => false, :null => false
    t.integer  "count_on_hand",                                             :default => 0,     :null => false
    t.integer  "count_pending_to_customer",                                 :default => 0,     :null => false
    t.integer  "count_pending_from_supplier",                               :default => 0,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
