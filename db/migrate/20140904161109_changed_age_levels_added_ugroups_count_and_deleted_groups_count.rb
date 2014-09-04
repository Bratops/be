class ChangedAgeLevelsAddedUgroupsCountAndDeletedGroupsCount < ActiveRecord::Migration
  def self.up
    add_column :age_levels, :ugroups_count, :integer
    remove_column :age_levels, :groups_count
  end
  
  def self.down
    add_column :age_levels, :groups_count, :integer, :limit=>nil, :default=>nil
    remove_column :age_levels, :ugroups_count
  end
end
