# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090928062008) do

  create_table "emails", :force => true do |t|
    t.string   "address"
    t.integer  "emailable_id"
    t.string   "emailable_type"
    t.boolean  "active",         :default => true
    t.datetime "inactive_at"
    t.datetime "deleted_at"
    t.datetime "effective_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "names", :force => true do |t|
    t.string   "first"
    t.string   "last"
    t.string   "middle"
    t.string   "suffix"
    t.string   "nickname"
    t.string   "title"
    t.integer  "nameable_id"
    t.string   "nameable_type"
    t.boolean  "active",        :default => true
    t.datetime "inactive_at"
    t.datetime "effective_at"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notification_methods", :force => true do |t|
    t.string   "name"
    t.string   "notification_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.integer  "person_type_id"
    t.integer  "notification_method_id"
    t.string   "first_social_security_number",  :limit => 11
    t.string   "middle_social_security_number", :limit => 11
    t.string   "last_social_security_number",   :limit => 11
    t.string   "drivers_license_number"
    t.date     "birth_date"
    t.boolean  "active",                                      :default => true, :null => false
    t.string   "sex",                           :limit => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                                         :null => false
    t.string   "crypted_password",                              :null => false
    t.string   "password_salt",                                 :null => false
    t.boolean  "active",             :default => false,         :null => false
    t.string   "persistence_token",  :default => "hellohadean", :null => false
    t.integer  "failed_login_count", :default => 0,             :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

end
