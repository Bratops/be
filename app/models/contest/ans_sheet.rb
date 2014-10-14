class Contest::AnsSheet < ActiveRecord::Base
  include Concerns::Contest::Score
  has_many :answers, class_name: "Contest::Ans",
    dependent: :destroy,
    foreign_key: :ans_sheet_id

  has_one :survey_sheet, class_name: "Survey::AnsSet",
    dependent: :destroy,
    foreign_key: :contest_ans_sheet_id

  belongs_to :user
  belongs_to :ugroup, class_name: "Edu::Ugroup"
  belongs_to :contest, class_name: "Contest::Info"

  def self.do_by_user user
    where(user: user, score: -1)
  end

  def need_fill_survey?
    self.survey_sheet && self.survey_sheet.not_finished
  end

  def task_finished?
    self.contest.tasks_count == self.ans_count
  end

  def status
    if task_finished?
      self.need_fill_survey? ? "survey" : "finished"
    else
      "testing"
    end
  end

  structure do
    score 0
    pr 0
    skips 0
    timespan 0

    ans_count 0

    timestamps
  end
end
