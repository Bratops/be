module V1::User::AnsSubmission
  extend ActiveSupport::Concern

  def submit
    find_ans
    mail_failure if @sta == :error
    render json: { status: :success }
  end

  private

  def find_ans
    @anss = current_user.current_answering
    @answer = @anss.answers.find_or_create_by(ans_params)
    update_ans if @answer
  end

  def update_ans
    @answer.update(full_ans_params)
    fill_answer
    rating_task
    if @answer.save
      @anss.grading_if_finished 1
      @sta = :success
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
    params.require(:ans).permit(:skip, :timespan)
  end

  def ans_params
    params.require(:ans).permit(:task_id)
  end
end
