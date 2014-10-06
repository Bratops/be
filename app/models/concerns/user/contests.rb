module Concerns::User::Contests
  extend ActiveSupport::Concern

  included do
    has_many :ans_sheets, class_name: "Contest::AnsSheet"
  end

  def current_contest_ans
    self.ans_sheets.find_by(score: -1)
  end
end
