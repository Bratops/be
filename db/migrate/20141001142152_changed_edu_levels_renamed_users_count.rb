class ChangedEduLevelsRenamedUsersCount < ActiveRecord::Migration
  def self.up
    rename_column :edu_levels, :users_count, :enrollments_count
  end
  
  def self.down
    rename_column :edu_levels, :enrollments_count, :users_count
  end
end
