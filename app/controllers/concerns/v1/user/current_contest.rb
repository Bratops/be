module V1::User::CurrentContest
  extend ActiveSupport::Concern

  def current
    find_contest
    load_or_create_ans_sheet
    render json: resp
  end

  private

  def id_param
    params.permit(:id)
  end

  def contest_info
    data = { status: @ans.status }
    if data[:status] == "testing"
      data[:contest] = ::User::Contest::DoSerializer.new(@contest)
      data[:done_ans] = @ans.answers.pluck(:task_id)
    end
    data
  end

  def resp
    if @contest && @ans
      contest_info
    else
      { status: "free" }
    end
  end

  def find_contest
    return unless current_user.can_do_contest_ids.include? params[:id]
    @contest = cache_with contest_key, expires_in: 3.day do
      Contest::Info.find_by(id_param)
    end
  end

  def contest_key
    "contest_#{params[:id]}"
  end

  def load_or_create_ans_sheet
    if @contest
      @ans = current_user.ans_sheets.find_or_create_by(new_ans_sheet_params)
      try_to_build_new_survey
    else
      @ans = current_user.current_answering
      @contest = @ans.contest if @ans
    end
  end

  def try_to_build_new_survey
    return if @contest.survey.nil?
    Survey::AnsSet.find_or_create_by(new_survey_params)
  end

  def new_survey_params
    {
      user: current_user,
      contest_ans_sheet: @ans,
      survey: @contest.survey,
    }
  end

  def new_ans_sheet_params
    {
      contest: @contest,
      score: -1,
      ugroup: current_user.ugroups.last
    }
  end
end
