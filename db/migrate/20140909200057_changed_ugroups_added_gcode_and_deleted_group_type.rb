class ChangedUgroupsAddedGcodeAndDeletedGroupType < ActiveRecord::Migration
  def self.up
    add_column :ugroups, :gcode, :string
    remove_column :ugroups, :group_type
  end
  
  def self.down
    add_column :ugroups, :group_type, :integer, :limit=>nil, :default=>nil
    remove_column :ugroups, :gcode
  end
end
