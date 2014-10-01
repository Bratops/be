class ChangedEduSchoolsRenamedUsersCount < ActiveRecord::Migration
  def self.up
    rename_column :edu_schools, :users_count, :enrollments_count
  end
  
  def self.down
    rename_column :edu_schools, :enrollments_count, :users_count
  end
end
