class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.integer    :person_type_id
      t.integer    :notification_method_id
      t.string     :first_social_security_number,   :limit => 11
      t.string     :middle_social_security_number,  :limit => 11
      t.string     :last_social_security_number,    :limit => 11
      t.string     :drivers_license_number
      t.date       :birth_date
      t.boolean    :active,                 :null => false, :default => true
      t.string     :sex, :limit => 1

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
