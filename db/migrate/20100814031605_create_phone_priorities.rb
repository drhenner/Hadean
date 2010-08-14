class CreatePhonePriorities < ActiveRecord::Migration
  def self.up
    create_table :phone_priorities do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :phone_priorities
  end
end
