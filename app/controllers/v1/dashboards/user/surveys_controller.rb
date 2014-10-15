class V1::Dashboards::User::SurveysController < V1::BaseController
  include V1::MessageHelper

  def current
    find_current_survey_sheet
    if @survey
      svy = ::User::Survey::InfoSerializer.new(@survey)
      data = { data: @survey_sheet.id, survey: svy, msg: cmsg(:success) }
    else
      data = {data: nil, survey: nil, msg: cmsg(:error) }
    end
    render json: data
  end

  def submit
    if Survey::AnsSet.update(params[:survey_sheet][:id], ans_set_params)
      @sta = :success
    end
    render json: { status: @sta }
  end

  private

  def setup
    @sta = :error
  end

  def find_current_survey_sheet
    @survey_sheet = current_user.survey_sheets.unfinished.first
    @survey = @survey_sheet.survey if @survey_sheet
  end

  def ans_set_params
    params.require(:survey_sheet).permit(
      ans_attributes: [ :quest_id, :ans_set_id,
        ans_choices_attributes: [
          :choice_id, comment_attributes: [ :content ] ]
      ]
    )
  end
end
