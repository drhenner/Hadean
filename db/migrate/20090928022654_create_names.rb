class CreateNames < ActiveRecord::Migration
  def self.up
    create_table :names do |t|
      t.string :first
      t.string :last
      t.string :middle
      t.string :suffix
      t.string :nickname
      t.string :title
      t.integer   :nameable_id
      t.string    :nameable_type
      t.boolean   :active, :default => true
      t.datetime  :inactive_at
      t.datetime  :effective_at
      t.datetime  :deleted_at
      t.timestamps
    end
  end
  
  def self.down
    drop_table :names
  end
end
