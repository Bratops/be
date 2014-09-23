class CreateEduClusters < ActiveRecord::Migration
  def self.up
    create_table :edu_clusters do |t|
      t.string :name 
      t.integer :ugroups_count 
    end
  end
  
  def self.down
    drop_table :edu_clusters
  end
end
