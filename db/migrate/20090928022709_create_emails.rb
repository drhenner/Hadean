class CreateEmails < ActiveRecord::Migration
  def self.up
    create_table :emails do |t|
      t.string    :address
      t.integer   :emailable_id
      t.string    :emailable_type
      t.boolean   :active,          :default => true
      t.datetime  :inactive_at
      t.datetime  :deleted_at
      t.datetime  :effective_at
      t.timestamps
    end
  end
  
  def self.down
    drop_table :emails
  end
end
