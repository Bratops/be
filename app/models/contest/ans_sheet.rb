class Contest::AnsSheet < ActiveRecord::Base
  has_many :answers, class_name: "Contest::Ans",
    dependent: :destroy,
    foreign_key: :ans_sheet_id

  belongs_to :user
  belongs_to :ugroup, class_name: "Edu::Ugroup"
  belongs_to :contest, class_name: "Contest::Info"

  def self.do_by_user user
    where(user: user, score: -1)
  end

  structure do
    score 0
    pr 0
    timespan 0

    ans_count 0

    timestamps
  end

  def da_score
    a = self.done_answers.find(aid)
    tty = self.user.target_type
    diff = a.task.task_levels.diffy(tty).first.difficulty.value
    cscore = a.option ? a.option.correct ? @@tscore[diff] : @@fscore[diff] : 0
  end

  def count_score
    _ca = Contest::Ansable::Single
    _score = 0
    ans_corrects(_ca).each do |aid, correct|
      tid = ans_tasks(_ca)[aid]
      rat = task_ratings[tid]
      _score += correct ? sc_correct[rat] : -1*sc_wrong[rat]
    end
    _score
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
