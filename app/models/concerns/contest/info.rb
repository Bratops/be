module Concerns::Contest::Info
  extend ActiveSupport::Concern
  included do
    has_many :task_items, class_name: "Contest::Task",
      dependent: :destroy,
      foreign_key: :contest_id
    has_many :tasks, through: :task_items, class_name: "Task::Info"
  end

  def score
    ba = [ nil, 12, 16, 20]
    ra = [ nil, 3, 4, 5]
    score = 0
    self.grading_tasks.pluck(:vote_weight).group_by{|v| v}.each do |k, v|
      score += (ba[k] + ra[k]) * v.count
    end
    score
  end

  def grading_str
    m = %w(beaver benjamin cadet junior senior)
    m[self.grading]
  end

  def grading_tasks
    self.tasks.joins(:votes_for).
      select("task_infos.id, tid, title, task_infos.created_at, vote_weight").
      where("vote_scope = '#{self.grading_str}_official'")
      #pluck("task_infos.id", :tid, :title, "task_infos.created_at", "vote_weight as rating")
  end

  def valid_start_date
    today = Date.today
    if self.sdate < today
      return today < self.edate ? today : (self.edate + 1.day)
    else
      self.sdate
    end
  end

  module ClassMethods
    def opening
      bod = Time.zone.now.beginning_of_day
      eod = Time.zone.now.end_of_day
      where("edate >= ? and sdate <= ?", bod, eod)
    end
  end

end
