class CreateRegistrationInfos < ActiveRecord::Migration
  def self.up
    create_table :registration_infos do |t|
      t.string :first_name  
      t.string :last_name
      t.date   :birthdate
      t.integer  :user_id
      t.timestamps
    end
    add_index :registration_infos, :first_name
    add_index :registration_infos, :last_name
  end

  def self.down
    drop_table :registration_infos
  end
end
