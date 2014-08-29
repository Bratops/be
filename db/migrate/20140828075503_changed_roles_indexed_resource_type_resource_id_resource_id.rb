class ChangedRolesIndexedResourceTypeResourceIdResourceId < ActiveRecord::Migration
  def self.up
    add_index :roles, [:resource_type, :resource_id]
    add_index :roles, :resource_id
  end
  
  def self.down
  end
end
