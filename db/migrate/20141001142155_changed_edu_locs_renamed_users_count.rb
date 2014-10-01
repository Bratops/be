class ChangedEduLocsRenamedUsersCount < ActiveRecord::Migration
  def self.up
    rename_column :edu_locs, :users_count, :enrollments_count
  end
  
  def self.down
    rename_column :edu_locs, :enrollments_count, :users_count
  end
end
