class ChangedTaskInfosAddedAuthsCountAndDeletedAuthorId < ActiveRecord::Migration
  def self.up
    add_column :task_infos, :auths_count, :integer
    remove_column :task_infos, :author_id
  end
  
  def self.down
    add_column :task_infos, :author_id, :integer, :limit=>nil, :default=>nil
    remove_column :task_infos, :auths_count
  end
end
