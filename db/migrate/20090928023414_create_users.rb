class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
    #t.string :login, :null => false
    #t.string :crypted_password, :null => false
    #t.string :password_salt, :null => false
    #t.string :persistence_token, :null => false
    #t.integer :login_count, :default => 0, :null => false
    
    
      t.string  :login,            :null => false
      t.string  :crypted_password,    :null => false
      t.string  :password_salt,       :null => false
      t.boolean :active,              :null => false, :default => false 
      t.string :persistence_token,    :null => false, :default => 'hellohadean'
      t.integer :failed_login_count,  :null => false, :default => 0
      t.timestamps
    end
      add_index :users, :login
      add_index :users, :persistence_token

    # create admin user
    admin_user = User.new(
                            :login  => "hadean_admin_user",
                            :password  => "stone",
                            :password_confirmation  => "stone",
                            :active    => true
                          )
    named_admin = admin_user.names = []
    named_admin = admin_user.names << Name.new(
                                          :first     => "Hadean",
                                          :last      => "User",
                                          :middle    => "Abe",
                                          :nickname  => "He Man",
                                          :effective_at => Time.now.to_s(:db),
                                          :active    => true
                                        )
    admin_user.emails = []
    admin_user.emails << Email.new(
                                    :address => "drhenner@hadeancorp.com",
                                    :effective_at => Time.now.to_s(:db),
                                    :active    => true
                                  )
    admin_user.save
    admin_user.errors.each do |err|
      puts err
    end
  end
  
  def self.down
    drop_table :users
  end
end
