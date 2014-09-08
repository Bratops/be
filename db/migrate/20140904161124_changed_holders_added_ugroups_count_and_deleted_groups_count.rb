class ChangedHoldersAddedUgroupsCountAndDeletedGroupsCount < ActiveRecord::Migration
  def self.up
    add_column :holders, :ugroups_count, :integer
    remove_column :holders, :groups_count
  end
  
  def self.down
    add_column :holders, :groups_count, :integer, :limit=>nil, :default=>nil
    remove_column :holders, :ugroups_count
  end
end
