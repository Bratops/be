class ChangedUsersAddedEnrollmentsCountGroupsCountAndDeletedGroupId < ActiveRecord::Migration
  def self.up
    add_column :users, :enrollments_count, :integer
    add_column :users, :groups_count, :integer
    remove_column :users, :group_id
  end
  
  def self.down
    add_column :users, :group_id, :integer, :limit=>nil, :default=>nil
    remove_column :users, :enrollments_count
    remove_column :users, :groups_count
  end
end
