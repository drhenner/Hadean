class CreateNotificationMethods < ActiveRecord::Migration
  def self.up
    create_table :notification_methods do |t|
      t.string   :name
      t.string   :notification_type
      t.timestamps
    end
    NotificationMethod.create(:name => "Email",       :notification_type => "Email")
    NotificationMethod.create(:name => "Cell Phone",  :notification_type => "CellPhone")
    NotificationMethod.create(:name => "Home Phone",  :notification_type => "HomePhone")
    NotificationMethod.create(:name => "Work Phone",  :notification_type => "WorkPhone")
  end

  def self.down
    drop_table :notification_methods
  end
end
