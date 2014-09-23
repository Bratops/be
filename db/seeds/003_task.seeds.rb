class << self
  # t.ttitle, t.tbody, t.tquest, t.texplain, t.tinfo, t.created_at, t.tid, t.region, t.weblinks, t.id
  def read_task_body year
    fs = "db/seeds/data/bebras/task_body_#{year}.csv"
    CSV.foreach(fs, row_sep: :auto, col_sep: "\t|") do |r|
      next if r.size < 10
      make_task r
    end
  end

  def make_task data
    t = Task::Info.mock
    attrs = %w[name body quest explain info created_at tid region link old_id]
    attrs.zip(data) do |k, v|
      t[k] = v
    end
    #puts t.name, t.created_at
    su = t.save
    if not su
      puts t.old_id, t.name
    end
  end
end

read_task_body 2013
