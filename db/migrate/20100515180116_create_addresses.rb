class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.integer  :address_type_id
      t.string   "first_name"
      t.string   "last_name"
      t.string   "address1"
      t.string   "address2"
      t.string   "city"
      t.integer  "state_id"
      t.string   "zip_code"
      #t.integer  "country_id"
      t.string   "phone"
      t.string   "state_name"
      t.string   "alternative_phone"
      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
