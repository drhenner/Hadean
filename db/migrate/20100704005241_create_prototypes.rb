class CreatePrototypes < ActiveRecord::Migration
  def self.up
    create_table :prototypes do |t|
      t.string      :name
      t.boolean     :active
    end
  end

  def self.down
    drop_table :prototypes
  end
end
