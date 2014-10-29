class Contest::Info < ActiveRecord::Base
  include Concerns::Contest::Info
  has_many :quests, class_name: "Survey::Quest",
    foreign_key: :survey_id, dependent: :destroy
  has_many :ans_sheets, class_name: "Contest::AnsSheet",
    foreign_key: "contest_id"

  has_many :regs, class_name: "Contest::Reg",
    foreign_key: "contest_id"

  belongs_to :survey, class_name: "Survey::Info"

  structure do
    name   "new contest", validates: [:presence]
    grading 4
    demo false

    sdate  :datetime
    edate  :datetime

    tasks_count 0
    regs_count 0

    timestamps
  end
end
