class V1::TaskController < V1::CacheController
  def_param_group :task do
    param :id, String, "Task public id in format \"year-region-id\"", required: true
  end
  skip_before_filter :authenticate_user_from_token!, :only => [:list]

  api :GET, "/task/:id", "Show task by given :id"
  param_group :task
  def show
    ck = "#{controller_name}.#{action_name}.#{params[:id]}"
    task = Rails.cache.fetch ck do
      y, r, t = params[:id].split('-')
      task = Task.in_year(y.to_i)
      task = task.where(region: r, tid: t).first
      TaskSerializer.new(task).to_json
    end
    render json: task
  end

  api :GET, "/task/list", "Get task information for list use"
  example " [ { task_id: '2013-xx-cc', name: 'example' } ] "
  def list
    # TODO sweep after create
    ck = "#{controller_name}.#{action_name}"
    tl = Rails.cache.fetch ck do
      task_list_json Task.all
    end
    render json: tl
  end

  api :GET, "/task/sweep", "Sweep task cache for update use"
  example " report sweep status "
  def sweep
    sk = "#{controller_name}.show.#{params[:id]}"
    Rails.cache.delete(sk)
    render json: { status: "done" }
  end

  private
  def task_list_json tasks
    aas = ActiveModel::ArraySerializer
    sts = SimpleTaskSerializer
    aas.new(tasks, each_serializer: sts).to_json
  end
end
