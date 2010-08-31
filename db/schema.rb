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

ActiveRecord::Schema.define(:version => 20100827061407) do

  create_table "accounts", :force => true do |t|
    t.string   "name",                                                            :null => false
    t.string   "account_type",                                                    :null => false
    t.decimal  "monthly_charge", :precision => 10, :scale => 0,                   :null => false
    t.boolean  "active",                                        :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "address_types", :force => true do |t|
    t.string "name",        :limit => 64
    t.string "description"
  end

  create_table "addresses", :force => true do |t|
    t.integer  "address_type_id"
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
    t.boolean  "default"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "item_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.integer "product_id"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "tax_category_id"
    t.integer  "shipping_category_id"
    t.integer  "product_type_id"
    t.datetime "available_at"
    t.datetime "deleted_at"
    t.string   "meta_keywords"
    t.string   "meta_description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "prototype_id"
    t.boolean  "featured",             :default => false
    t.string   "permalink",                               :null => false
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

  create_table "shipping_categories", :force => true do |t|
    t.string "name", :null => false
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
    t.string  "abbreviation", :limit => 5
    t.string  "described_as"
    t.integer "country_id"
  end

  create_table "suppliers", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
