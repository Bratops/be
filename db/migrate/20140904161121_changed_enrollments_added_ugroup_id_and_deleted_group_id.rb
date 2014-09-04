class ChangedEnrollmentsAddedUgroupIdAndDeletedGroupId < ActiveRecord::Migration
  def self.up
    add_column :enrollments, :ugroup_id, :integer
    remove_column :enrollments, :group_id
    add_index :enrollments, :ugroup_id
  end
  
  def self.down
    add_column :enrollments, :group_id, :integer, :limit=>nil, :default=>nil
    remove_column :enrollments, :ugroup_id
  end
end
