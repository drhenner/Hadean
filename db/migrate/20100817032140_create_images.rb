class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.integer :imageable_id
      t.string  :imageable_type
      t.integer :image_height
      t.integer :image_width
      t.integer :position
      t.string  :caption
    end
  end

  def self.down
    drop_table :images
  end
end
