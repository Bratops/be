class ChangedLocationsAddedUgroupsCountAndDeletedGroupsCount < ActiveRecord::Migration
  def self.up
    add_column :locations, :ugroups_count, :integer
    remove_column :locations, :groups_count
  end
  
  def self.down
    add_column :locations, :groups_count, :integer, :limit=>nil, :default=>nil
    remove_column :locations, :ugroups_count
  end
end
