class Contest::Task < ActiveRecord::Base
  belongs_to :task, class_name: "Task::Info"
  counter_culture :task, column_name: "contests_count"

  belongs_to :contest, class_name: "Contest::Info"
  counter_culture :contest, column_name: "tasks_count"

  structure do
  end
end
