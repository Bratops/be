class ChangedTaskChoicesAddedTaskAnsIdAndModifiedContentAndRenamedTaskInfoIdAndIndexedTaskChoiceId < ActiveRecord::Migration
  def self.up
    add_column :task_choices, :task_ans_id, :integer
    change_column :task_choices, :content, :text
    rename_column :task_choices, :task_info_id, :task_choice_id
    add_index :task_choices, :task_ans_id
  end
  
  def self.down
    rename_column :task_choices, :task_choice_id, :task_info_id
    change_column :task_choices, :content, :string, :limit=>255, :default=>nil
    remove_column :task_choices, :task_ans_id
  end
end
