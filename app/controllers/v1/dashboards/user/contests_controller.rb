class V1::Dashboards::User::ContestsController < V1::CacheController
  include V1::MessageHelper
  before_filter :setup

  def index
    find_contests
    us = ActiveModel::ArraySerializer.new(@contests, each_serializer: ::Contest::InfSerializer)
    render json: {
      msg: tmsg(@sta, current_user.xrole.name),
      data: us
    }
  end

  def current
    if contestable
      find_contest
      find_ans_sheet
    end
    render json: contest_data
  end

  def submit
    find_ans
    mail_failure if @sta == :error
    render json: { status: :success }
  end

  private

  def find_ans
    @anss = Contest::AnsSheet.do_by_user(current_user).first
    data = {ans_sheet_id: @anss.id}
    @answer = Contest::Ans.find_by(ans_params.merge(data))
    unless @answer
      @answer = Contest::Ans.create(full_ans_params.merge(data))
      fill_answer
      rating_task
      @sta = :success if @answer.save
    end
  end

  def rating_task
    rp = rating_params
    task = Task::Info.find rp[:task_id]
    task.vote_by voter: current_user,
      vote_scope: "#{@anss.contest.grading_str}_user",
      vote_weight: rp[:rating]
  end

  def mail_failure
    ContestMailer.ans_fail(current_user, params, @answer.errors.messages).deliver
  end

  def fill_answer
    ans = params[:ans]
    @answer.status = ans[:ans].blank? ? 1 : 2
    if ans[:kind] == "single"
      @answer.ansable = Contest::Ansable::Single.new(choice_id: ans[:ans])
    elsif ans[:kind] == "fill"
      @answer.ansable = Contest::Ansable::Fill.new(content: ans[:ans])
    end
  end

  def rating_params
    params.require(:ans).permit( :task_id, :rating)
  end

  def full_ans_params
    params.require(:ans).permit( :task_id, :skip, :timespan)
  end

  def ans_params
    params.require(:ans).permit( :task_id)
  end

  def contest_data
    if @contest && @ans
      if @contest.tasks_count == @ans.ans_count
        { status: "finished" }
      else
        { status: "testing",
          contest: ::User::Contest::DoSerializer.new(@contest),
          done_ans: @ans.answers.pluck(:task_id) }
      end
    else
      { status: "free" }
    end
  end

  def find_ans_sheet
    if @contest
      @ans = Contest::AnsSheet.find_or_create_by(new_ans_sheet_params)
    else
      @ans = current_user.current_contest_ans
      @contest = @ans.contest if @ans
    end
  end

  def find_contest
    key = "contest_#{params[:id]}"
    @contest = cache_with key, expires_in: 3.day do
      Contest::Info.find_by(id: params[:id], grading: @grading)
    end
  end

  def new_ans_sheet_params
    { user: current_user,
      score: -1,
      contest: @contest,
      ugroup: current_user.nondone_enrolls.first.ugroup }
  end

  def find_contests
    @contests = []
    if contestable
      @sta = :success
      @contests = Contest::Info.where(grading: @grading)
    else
      @sta = :warning
    end
  end

  def setup
    @sta = :error
    @grading = current_user.nondone_enrolls.first.ugroup.grading
  end

  def contestable
    current_user.nondone_enrolls.first.contestable
  end

end
