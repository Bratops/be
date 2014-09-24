class Task::Choice < ActiveRecord::Base
  belongs_to :task, class_name: "Task::Info",
    foreign_key: :task_info_id

  structure do
    index 0
    content :text, " task content "
    answer false
  end
end
