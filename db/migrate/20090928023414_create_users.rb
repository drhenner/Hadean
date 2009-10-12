class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      #t.integer :email_id
      #t.integer :current_name_id,     :null => false
      t.string  :username,            :null => false
      t.string  :crypted_password,    :null => false
      t.string  :password_salt,       :null => false
      t.boolean :active,              :null => false, :default => false 
      t.string  :persistance_token
      t.integer :failed_login_count,  :null => false, :default => 0
      t.timestamps
    end

    # create admin user
    admin_user = User.new(
                            :username  => "hadean_admin_user",
                            :password  => "stone",
                            :password_confirmation  => "stone",
                            :active    => true
                          )
    named_admin = admin_user.active_name.build(
                                         :first     => "Hadean",
                                         :last      => "User",
                                         :middle    => "Abe",
                                         :nickname  => "He Man",
                                         :effective_at => Time.now.to_s(:db)
                                       )
    named_admin.active_email.build(
                                    :address => "drhenner@hadeancorp.com",
                                    :effective_at => Time.now.to_s(:db)
                                  ).save
  end
  
  def self.down
    drop_table :users
  end
end
