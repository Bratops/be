class ChangedGroupsAddedEnrollmentsCount < ActiveRecord::Migration
  def self.up
    add_column :groups, :enrollments_count, :integer
  end
  
  def self.down
    remove_column :groups, :enrollments_count
  end
end
