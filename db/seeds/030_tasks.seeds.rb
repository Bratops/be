class << self
  def update_tasks
    file = File.open("db/seeds/data/bebras/task_all.txt")
    tsk = nil
    file.each_line do |fl|
      tsk = get_task(fl) if fl.start_with?("{old_id")
      update_tid(tsk, fl) if fl.start_with?("  {tid")
      add_choices(tsk, fl) if fl.start_with?("  {index")
      add_authors(tsk, fl) if fl.start_with?("  {author")
      update_rating(tsk, fl) if fl.start_with?("  {name")
      add_keywords(tsk, fl) if fl.start_with?("  {keyword")
      add_klass(tsk, fl) if fl.start_with?("  {klass")
      tsk.save
    end
  end

  def update_rating tsk, fl
    return unless tsk
    hv = eval fl
    u = User.manager
    tsk.vote_by voter: u, vote_scope: hv[:name], vote_weight: hv[:rating]
  end

  def add_keywords tsk, fl
    hv = eval(fl)
    tsk.keyword_list = hv[:keywords]
  end

  def add_klass tsk, fl
    hv = eval(fl)
    tsk.klass_list = hv[:klass]
  end

  def add_authors tsk, fl
    return unless tsk
    hv = eval(fl)
    au = Task::Author.new(hv[:author])
    cn = Task::Country.find_or_create_by(hv[:country])
    au.country = cn
    au.save
    ta = tsk.authors.new(hv[:auth])
    ta.author = au
    ta.save
  end

  def update_tid tsk, fl
    return unless tsk
    tsk.update(eval(fl))
  end

  def add_choices tsk, fl
    return unless tsk
    fa = fl.split("$$$$$")
    hv = eval(fa[0])
    hv[:content] = fa[1]
    cho = Task::Choice.new(hv)
    tsk.choices << cho
  end

  def get_task fl
    Task::Info.find_by(eval(fl))
  end
end

update_tasks
