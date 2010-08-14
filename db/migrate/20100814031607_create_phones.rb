class CreatePhones < ActiveRecord::Migration
  def self.up
    create_table :phones do |t|
      t.integer  :phone_type_id
      t.string   "number",          :null => false
      t.string   'phoneable_type',  :null => false
      t.integer  'phoneable_id',    :null => false
      t.boolean  "primary",         :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :phones
  end
end
