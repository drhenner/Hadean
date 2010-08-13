class CreateUserRoles < ActiveRecord::Migration
  def self.up
    create_table :user_roles do |t|
      t.integer :role_id, :null => false
      t.integer :user_id, :null => false
    end
    add_index :user_roles, :role_id
    add_index :user_roles, :user_id
    
    execute "alter table user_roles add constraint fk_user_roles_role_id foreign key (role_id) references roles(id)"
    execute "alter table user_roles add constraint fk_user_roles_user_id foreign key (user_id) references users(id)"

  end

  def self.down
    execute "alter table user_roles drop foreign key fk_user_roles_role_id"
    execute "alter table user_roles drop foreign key fk_user_roles_user_id"
    drop_table :user_roles
  end
end
