require "csv"

namespace :csv do
  desc "Load data from csv"
  task :read => [:environment] do
    read_task
    puts "yes"
  end

  # t.ttitle, t.tbody, t.tquest, t.texplain, t.tinfo, t.created_at, t.tid, t.region, t.weblinks, t.id
  def read_task
    CSV.foreach("tmp/task.csv", :row_sep => :auto, :col_sep => "\t|") do |r|
      next if r.size < 10
      make_task r
    end
  end

  def make_task data
    t = Task.mock
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
