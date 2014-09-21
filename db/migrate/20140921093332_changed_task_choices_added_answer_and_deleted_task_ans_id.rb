class ChangedTaskChoicesAddedAnswerAndDeletedTaskAnsId < ActiveRecord::Migration
  def self.up
    add_column :task_choices, :answer, :boolean
    remove_column :task_choices, :task_ans_id
  end
  
  def self.down
    add_column :task_choices, :task_ans_id, :integer, :limit=>nil, :default=>nil
    remove_column :task_choices, :answer
  end
end
