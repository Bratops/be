class ChangedEduUgroupsRenamedKlassAndIndexedClusterId < ActiveRecord::Migration
  def self.up
    rename_column :edu_ugroups, :klass, :cluster_id
    add_index :edu_ugroups, :cluster_id
  end
  
  def self.down
    rename_column :edu_ugroups, :cluster_id, :klass
  end
end
