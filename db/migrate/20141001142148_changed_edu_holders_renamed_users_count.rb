class ChangedEduHoldersRenamedUsersCount < ActiveRecord::Migration
  def self.up
    rename_column :edu_holders, :users_count, :enrollments_count
  end
  
  def self.down
    rename_column :edu_holders, :enrollments_count, :users_count
  end
end
