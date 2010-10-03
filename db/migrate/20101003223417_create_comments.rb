class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :note
      t.string :commentable_type
      t.integer :commentable_id
      t.integer :created_by
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
