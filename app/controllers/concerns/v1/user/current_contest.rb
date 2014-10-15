module V1::User::CurrentContest
  extend ActiveSupport::Concern

  def current
    if contestable
      find_contest
      find_ans_sheet
    end
    render json: contest_info
  end

  private

  def ans_sheet_info
    data = { status: @ans.status }
    if data[:status] == "testing"
      data[:contest] = ::User::Contest::DoSerializer.new(@contest)
      data[:done_ans] = @ans.answers.pluck(:task_id)
    end
    data
  end

  def contest_info
    if @contest && @ans
      ans_sheet_info
    else
      { status: "free" }
    end
  end

  def find_contest
    key = "contest_#{params[:id]}"
    @contest = cache_with key, expires_in: 3.day do
      Contest::Info.find_by(id: params[:id], grading: @grading)
    end
  end

  def build_ans_sheet
    @ans = Contest::AnsSheet.find_or_create_by(new_ans_sheet_params)
    Survey::AnsSet.find_or_create_by(contest_ans_sheet: @ans, survey: @contest.survey, user: current_user)
    @ans.score = -1
  end

  def find_ans_sheet
    if @contest
      build_ans_sheet
    else
      @ans = current_user.current_contest_ans
      @contest = @ans.contest if @ans
    end
  end

  def new_ans_sheet_params
    { user: current_user,
      contest: @contest,
      ugroup: current_user.nondone_enrolls.first.ugroup }
  end

end
