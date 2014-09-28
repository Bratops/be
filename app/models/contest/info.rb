class Contest::Info < ActiveRecord::Base
  has_many :task_items, class_name: "Contest::Task",
    dependent: :destroy,
    foreign_key: :contest_id

  has_many :tasks, through: :task_items, class_name: "Task::Info"

  def grading_str
    m = %w(beaver benjamin cadet junior senior)
    m[self.grading]
  end

  def grading_tasks
    self.tasks.joins(:votes_for).
      select("task_infos.id, tid, title, task_infos.created_at, vote_weight").
      where("vote_scope = '#{self.grading_str}_official'").all
  end

  structure do
    name   "new contest", validates: [:presence]
    grading 4
    sdate  :datetime
    edate  :datetime

    tasks_count 0
  end
end
