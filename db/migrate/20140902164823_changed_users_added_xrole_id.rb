class ChangedUsersAddedXroleId < ActiveRecord::Migration
  def self.up
    add_column :users, :xrole_id, :string
  end
  
  def self.down
    remove_column :users, :xrole_id
  end
end
