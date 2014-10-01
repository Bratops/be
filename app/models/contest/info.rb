class Contest::Info < ActiveRecord::Base
  include Concerns::Contest::Info
  has_many :ans_sheets, class_name: "Contest::AnsSheet",
    foreign_key: "contest_id"

  structure do
    name   "new contest", validates: [:presence]
    grading 4
    sdate  :datetime
    edate  :datetime

    tasks_count 0

    timestamps
  end
end
