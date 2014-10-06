class Task::Info < ActiveRecord::Base
  acts_as_taggable_on :klasses, :keywords, :opens
  acts_as_votable

  has_many :contest_items, class_name: "Contest::Task",
    dependent: :destroy,
    foreign_key: :task_id

  has_many :contests, through: :contest_items, class_name: "Contest::Info"

  has_many :answers, class_name: "Contest::Ans", dependent: :destroy

  has_many :authors, class_name: "Task::Auth",
    dependent: :destroy,
    foreign_key: :task_id

  has_many :choices, class_name: "Task::Choice",
    dependent: :destroy,
    foreign_key: :task_info_id

  scope :in_year, ->(year) { where("created_at BETWEEN ? AND ?", Time.new(year), Time.new(year+1)) }

  def grade_rating grade
    self.find_votes_for(vote_scope: "#{grade}_official").first.vote_weight
  end

  structure do
    tid       "AA-bbbb-cc", validates: [:presence, :uniqueness], index: true
    title     "New Task", validates: :presence
    body      :text, " A question context.       ", validates: :presence
    explain   :text, " This is what the task is. ", validates: :presence
    quest     :text, " What should be solved?    ", validates: :presence
    info      :text, " Some information          "
    link      :text, " http://bebras.tw/newtask  "
    old_id    -1
    type      0  # choice, blank filling, multi-select

    auths_count 0
    ans_count 0
    contests_count 0

    timestamps

    cached_votes_total 0, index: true
    cached_votes_score 0, index: true
    cached_votes_up 0, index: true
    cached_votes_down  0, index: true
    cached_weighted_score 0, index: true
    cached_weighted_total 0, index: true
    cached_weighted_average 0.0
  end
end
