class CreateStates < ActiveRecord::Migration
  def self.up
    create_table :states do |t|
      
      t.string :name,                       :null => false
      t.string :abbreviation, :limit => 5,  :null => false,   :unique => true
      t.string :described_as
      t.integer :country_id,                :null => false
    end
    add_index :states, :name
    add_index :states, :country_id
  end

  def self.down
    drop_table :states
  end
end
