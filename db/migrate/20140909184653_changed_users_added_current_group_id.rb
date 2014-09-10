class ChangedUsersAddedCurrentGroupId < ActiveRecord::Migration
  def self.up
    add_column :users, :current_group_id, :integer
    add_index :users, :current_group_id
  end
  
  def self.down
    remove_column :users, :current_group_id
  end
end
