class Task::Info < ActiveRecord::Base
  acts_as_taggable_on :klasses, :keywords, :opens
  acts_as_votable

  has_many :authors, class_name: "Task::Auth",
    dependent: :destroy,
    foreign_key: :task_id

  has_many :choices, class_name: "Task::Choice",
    dependent: :destroy,
    foreign_key: :task_info_id

  scope :in_year, ->(year) { where("created_at BETWEEN ? AND ?", Time.new(year), Time.new(year+1)) }

  structure do
    tid       "AA-bbbb-cc", validates: [:presence, :uniqueness], index: true
    title     "New Task", validates: :presence
    body      :text, " A question context.       ", validates: :presence
    explain   :text, " This is what the task is. ", validates: :presence
    quest     :text, " What should be solved?    ", validates: :presence
    info      :text, " Some information          "
    link      :text, " http://bebras.tw/newtask  "
    old_id    -1
    timestamps

    auths_count 0

    cached_votes_total 0, index: true
    cached_votes_score 0, index: true
    cached_votes_up 0, index: true
    cached_votes_down  0, index: true
    cached_weighted_score 0, index: true
    cached_weighted_total 0, index: true
    cached_weighted_average 0.0
  end
end
