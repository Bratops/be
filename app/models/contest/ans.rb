class Contest::Ans < ActiveRecord::Base
  belongs_to :ans_sheet, class_name: "Contest::AnsSheet"
  counter_culture :ans_sheet, column_name: "ans_count"

  belongs_to :task, class_name: "Task::Info"
  counter_culture :task, column_name: "ans_count"

  belongs_to :ansable, polymorphic: true,
    dependent: :destroy

  structure do
    status 0 # open, skipped, confirmed
    skip 0
    timespan 0

    ansable_type ""

    timestamps
  end
end
