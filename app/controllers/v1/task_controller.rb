class V1::TaskController < V1::BaseController
  include ActionController::Caching
  self.perform_caching = true
  self.cache_store = ActionController::Base.cache_store

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

  def list
    # TODO sweep after create
    ck = "#{controller_name}.#{action_name}"
    tl = Rails.cache.fetch ck do
      task_list_json Task.all
    end
    render json: tl
  end

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
