class ChangedTaskChoicesRenamedTaskChoiceIdAndIndexedTaskInfoId < ActiveRecord::Migration
  def self.up
    rename_column :task_choices, :task_choice_id, :task_info_id
  end
  
  def self.down
    rename_column :task_choices, :task_info_id, :task_choice_id
  end
end
