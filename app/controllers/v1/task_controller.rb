class V1::TaskController < V1::BaseController
  include ActionController::Caching
  self.perform_caching = true
  self.cache_store = ActionController::Base.cache_store

  def show
    task = cache [:show, params[:id]] do
      task = Task.find(params[:id])
      TaskSerializer.new(task).to_json
    end
    render json: task
  end

  def list
  end
end
