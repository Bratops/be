class Task::Choice < ActiveRecord::Base
  belongs_to :choice_for, class_name: "Task::Info",
    foreign_key: :task_choice_id

  structure do
    index 0
    content :text, " task content "
    answer false
  end
end
