module Concerns::User::Contests
  extend ActiveSupport::Concern

  included do
    has_many :ans_sheets, class_name: "Contest::AnsSheet"
  end

  def current_answering
    self.ans_sheets.find_by(score: -1)
  end

  def can_do_contests
    ::Contest::Info.where(id: can_do_contest_ids)
  end

  def can_do_contest_ids
    _available = ::Contest::Reg.where(ugroup: self.ugroups).available.pluck :contest_id
    _finished = self.ans_sheets.
      where(contest: _available).
      where("score >= 0").pluck :contest_id
    _available - _finished
  end

end
