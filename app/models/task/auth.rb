class Task::Auth < ActiveRecord::Base

  belongs_to :author, class_name: "Task::Author",
    dependent: :destroy
  counter_culture :author, column_name: "tasks_count"

  belongs_to :task, class_name: "Task::Info",
    dependent: :destroy
  counter_culture :task, column_name: "auths_count"

  structure do
    timestamps
  end
end
