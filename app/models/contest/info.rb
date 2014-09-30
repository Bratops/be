class Contest::Info < ActiveRecord::Base
  include Concerns::Contest::Info
  has_many :task_items, class_name: "Contest::Task",
    dependent: :destroy,
    foreign_key: :contest_id

  structure do
    name   "new contest", validates: [:presence]
    grading 4
    sdate  :datetime
    edate  :datetime

    tasks_count 0
  end
end
