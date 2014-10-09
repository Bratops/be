class V1::Dashboards::Manager::SurveysController < V1::BaseController
  include V1::MessageHelper
  before_filter :setup

  def index
    surveys = Survey::Info.last(20)
    aas = ActiveModel::ArraySerializer
    mts = ::Manager::Survey::InfoSerializer
    render json: aas.new(surveys, each_serializer: mts)
  end

  def create
    sv = Survey::Info.new(survey_params)
    @sta = :success if sv.save
    render json: { msg: cmsg(@sta) }
  end

  def show
    survey = Survey::Info.find(params[:id])
    mts = ::Manager::Survey::InfoSerializer
    render json: {
      data: mts.new(survey),
      status: survey ? "success" : "error"
    }
  end

  def destroy
    survey = Survey::Info.find(params[:id])
    @sta = "success" if survey.destroy
    render json: { msg: cmsg(@sta) }
  end

  def update
    sv = Survey::Info.find(params[:id])
    @sta = :success if sv && sv.update(survey_params)
    render json: { msg: cmsg(@sta) }
  end

  private

  def setup
    authorize! :manage, Survey
    @sta = :error
  end

  def survey_params
    params.require(:survey).permit(
      :name, :info, quests_attributes: [
        :id, :order, :qtype, :content, :_destroy, choices_attributes: [
          :id, :order, :commentable, :content, :_destroy]
      ]
    )
  end

end
