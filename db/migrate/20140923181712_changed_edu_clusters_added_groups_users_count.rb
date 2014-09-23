class ChangedEduClustersAddedGroupsUsersCount < ActiveRecord::Migration
  def self.up
    add_column :edu_clusters, :groups_users_count, :integer
  end
  
  def self.down
    remove_column :edu_clusters, :groups_users_count
  end
end
