class ChangedUsersRolesIndexedUserIdRoleId < ActiveRecord::Migration
  def self.up
    add_index :users_roles, :user_id
    add_index :users_roles, :role_id
  end
  
  def self.down
  end
end
