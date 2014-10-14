class Survey::AnsSet < ActiveRecord::Base
  belongs_to :survey, class_name: "Survey::Info"
  belongs_to :user, class_name: "User"

  belongs_to :contest_ans_sheet, class_name: "Contest::AnsSheet"

  has_many :ans, class_name: "Survey::Ans"

  def finished?
    self.ans_count == self.survey.quests_count
  end

  def not_finished
    self.ans_count.nil? ||
    self.ans_count < self.survey.quests_count
  end

  structure do
    ans_count 0
  end
end
