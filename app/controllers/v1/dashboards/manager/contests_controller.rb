class V1::Dashboards::Manager::ContestsController < V1::BaseController
  include V1::MessageHelper
  before_filter :setup

  def index
    @contests = Contest::Info.all
    aas = ActiveModel::ArraySerializer
    mts = ::Manager::Contest::RawSerializer
    @contests = aas.new(@contests, each_serializer: mts)
    render json: @contests
  end

  def create
    create_contest
    @contest = ::Manager::Contest::RawSerializer.new(@contest)
    render json: {
      msg: tmsg(@sta, current_user.xrole.name),
      data: @contest
    }
  end

  def update
    update_contest
    render json: {
      msg: tmsg(@sta, current_user.xrole.name),
      data: @contest
    }
  end

  def destroy
    contest = Contest::Info.find_by_id(params[:id])
    if contest.destroy
      @sta = :success
    end
    render json: { msg: tmsg(@sta, current_user.xrole.name) }
  end

  def show
    contest = Contest::Info.find_by_id(params[:id])
    if contest
      contest = ::Manager::Contest::RawSerializer.new(contest)
      @sta = :success
    end
    render json: {
      status: @sta,
      data: contest
    }
  end

  private

  def setup
    authorize! :manage, Contest
    @sta = :error
  end

  def update_contest
    @contest = Contest::Info.find_by_id(params[:id])
    if @contest && @contest.update(contest_params)
      update_task_items
      @sta = :success
      @contest = ::Manager::Contest::RawSerializer.new(@contest)
    end
  end

  def update_task_items
    return unless Contest::AnsSheet.find_by(contest: @contest).nil?
    tids = @contest.task_items.pluck :task_id
    removed = tids - tasks_params
    @contest.task_items.where(task_id: removed).delete_all
    added = tasks_params - tids
    update_task_ratings added
  end

  def create_contest
    @contest = Contest::Info.new(contest_params)
    if @contest.save
      update_task_ratings tasks_params
      @sta = :success
    end
  end

  def update_task_ratings tids
    tids.each do |tp|
      rat = Task::Info.find(tp).grade_rating @contest.grading_str
      @contest.task_items.create(task_id: tp, rating: rat)
    end
  end

  def tasks_params
    params.require(:contest).permit( task_ids: [] )[:task_ids]
  end

  def contest_params
    params.require(:contest).permit(
      :name, :grading, :sdate, :edate, :demo, :survey_id
    )
  end
end
