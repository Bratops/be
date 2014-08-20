class V1::TaskController < V1::BaseController
  def index
    render json: Task.first
  end
end
