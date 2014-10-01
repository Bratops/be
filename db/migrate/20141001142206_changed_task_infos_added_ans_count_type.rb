class ChangedTaskInfosAddedAnsCountType < ActiveRecord::Migration
  def self.up
    add_column :task_infos, :ans_count, :integer
    add_column :task_infos, :type, :integer
  end
  
  def self.down
    remove_column :task_infos, :ans_count
    remove_column :task_infos, :type
  end
end
