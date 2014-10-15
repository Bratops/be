class Survey::AnsSet < ActiveRecord::Base
  belongs_to :survey, class_name: "Survey::Info"
  belongs_to :user, class_name: "User"

  belongs_to :contest_ans_sheet, class_name: "Contest::AnsSheet"

  has_many :ans, class_name: "Survey::Ans",
    dependent: :destroy

  accepts_nested_attributes_for :ans

  def finished?
    self.ans_count == self.survey.quests_count
  end

  def not_finished
    self.ans_count.nil? ||
    self.ans_count < self.survey.quests_count
  end

  scope :unfinished, -> {
    no_ans = "ans_count is NULL"
    not_fin = "ans_count < survey_infos.quests_count "
    joins(:survey).where("#{no_ans} or #{not_fin}")
  }

  structure do
    ans_count 0
  end
end
