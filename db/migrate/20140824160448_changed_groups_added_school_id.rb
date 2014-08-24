class ChangedGroupsAddedSchoolId < ActiveRecord::Migration
  def self.up
    add_column :groups, :school_id, :integer
    add_index :groups, :school_id
  end
  
  def self.down
    remove_column :groups, :school_id
  end
end
