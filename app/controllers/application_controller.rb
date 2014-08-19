class ApplicationController < ActionController::API
  def landing
    render json: { cool: "ok" }
  end
end
