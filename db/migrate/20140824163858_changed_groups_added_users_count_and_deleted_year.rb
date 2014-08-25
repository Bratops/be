class ChangedGroupsAddedUsersCountAndDeletedYear < ActiveRecord::Migration
  def self.up
    add_column :groups, :users_count, :integer
    remove_column :groups, :year
  end
  
  def self.down
    add_column :groups, :year, :integer, :limit=>nil, :default=>nil
    remove_column :groups, :users_count
  end
end
