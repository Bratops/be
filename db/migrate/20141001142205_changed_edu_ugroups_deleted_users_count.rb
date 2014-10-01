class ChangedEduUgroupsDeletedUsersCount < ActiveRecord::Migration
  def self.up
    remove_column :edu_ugroups, :users_count
  end
  
  def self.down
    add_column :edu_ugroups, :users_count, :integer, :limit=>nil, :default=>nil
  end
end
