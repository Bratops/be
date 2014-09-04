class ChangedSchoolsAddedUgroupsCountAndDeletedGroupsCount < ActiveRecord::Migration
  def self.up
    add_column :schools, :ugroups_count, :integer
    remove_column :schools, :groups_count
  end
  
  def self.down
    add_column :schools, :groups_count, :integer, :limit=>nil, :default=>nil
    remove_column :schools, :ugroups_count
  end
end
