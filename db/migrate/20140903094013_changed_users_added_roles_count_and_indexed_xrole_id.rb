class ChangedUsersAddedRolesCountAndIndexedXroleId < ActiveRecord::Migration
  def self.up
    add_column :users, :roles_count, :integer
    add_index :users, :xrole_id
  end
  
  def self.down
    remove_column :users, :roles_count
  end
end
