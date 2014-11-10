module Concerns::Contest::Score
  extend ActiveSupport::Concern

  included do
  end

  def grading_if_finished diff=0
    grading if finished_in(diff)
  end

  def grading
    self.score = compute_score
    self.skips = compute_skips
    self.timespan = compute_timing
    self.save
  end

  def compute_score
    scoring Contest::Ansable::Single
  end

  def compute_skips
    self.answers.sum :skip
  end

  def compute_timing
    self.answers.sum :timespan
  end

  private

  def finished_in diff
    self.ans_count == (self.contest.tasks_count - diff)
  end

  def scoring ansable
    _score = 0
    ans_corrects(ansable).each do |aid, correct|
      tid = ans_tasks(ansable)[aid]
      rat = task_ratings[tid]
      _score += correct ? sc_correct[rat] : -1*sc_wrong[rat]
    end
    _score >= 0 ? _score : 0
  end

  def ans_corrects at
    aid = self.answers.where(ansable_type: at).pluck :ansable_id
    ta = at.select("#{at.table_name}.id, task_choices.answer").where(id: aid).joins(:choice).pluck :id, :answer
    ta.inject({}) {|h, v| h[v[0]] = v[1]; h }
  end

  def ans_tasks at
    ta = self.answers.where(ansable_type: at).pluck :ansable_id, :task_id
    ta.inject({}) {|h, v| h[v[0]] = v[1]; h }
  end

  def task_ratings
    ta = self.contest.task_items.pluck :task_id, :rating
    ta.inject({}) {|h, v| h[v[0]] = v[1]; h }
  end

  def sc_correct
    [ nil, 12, 16, 20 ]
  end

  def sc_wrong
    [ nil, 3, 4, 5 ]
  end
end
