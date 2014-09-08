class ChangedUsersAddedUgroupsCountAndDeletedGroupsCount < ActiveRecord::Migration
  def self.up
    add_column :users, :ugroups_count, :integer
    remove_column :users, :groups_count
  end
  
  def self.down
    add_column :users, :groups_count, :integer, :limit=>nil, :default=>nil
    remove_column :users, :ugroups_count
  end
end
