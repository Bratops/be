class V1::Dashboards::Manager::SurveysController < V1::BaseController
  include V1::MessageHelper
  before_filter :setup

  def index
  end

  def create
    render json: {
      msg: cmsg(@sta)
    }
  end

  def destroy
  end

  def update
  end

  private

  def setup
    authorize! :manage, Survey
    @sta = :error
  end

  def survey_params
  end

end
