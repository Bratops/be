class ChangedTaskChoicesAddedIndexTaskInfoId < ActiveRecord::Migration
  def self.up
    add_column :task_choices, :index, :integer
    add_column :task_choices, :task_info_id, :integer
    add_index :task_choices, :task_info_id
  end
  
  def self.down
    remove_column :task_choices, :index
    remove_column :task_choices, :task_info_id
  end
end
