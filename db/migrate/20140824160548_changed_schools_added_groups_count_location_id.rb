class ChangedSchoolsAddedGroupsCountLocationId < ActiveRecord::Migration
  def self.up
    add_column :schools, :groups_count, :integer
    add_column :schools, :location_id, :integer
    add_index :schools, :location_id
  end
  
  def self.down
    remove_column :schools, :groups_count
    remove_column :schools, :location_id
  end
end
