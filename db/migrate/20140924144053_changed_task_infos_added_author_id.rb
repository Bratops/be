class ChangedTaskInfosAddedAuthorId < ActiveRecord::Migration
  def self.up
    add_column :task_infos, :author_id, :integer
    add_index :task_infos, :author_id
  end
  
  def self.down
    remove_column :task_infos, :author_id
  end
end
