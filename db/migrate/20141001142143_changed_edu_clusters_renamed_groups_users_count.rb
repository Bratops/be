class ChangedEduClustersRenamedGroupsUsersCount < ActiveRecord::Migration
  def self.up
    rename_column :edu_clusters, :groups_users_count, :enrollments_count
  end
  
  def self.down
    rename_column :edu_clusters, :enrollments_count, :groups_users_count
  end
end
