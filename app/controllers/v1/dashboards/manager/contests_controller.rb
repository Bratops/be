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

  def create_contest
    @contest = Contest::Info.new(contest_params)
    if @contest.save
      tasks_params.each do |tp|
        @contest.task_items.create(task_id: tp)
      end
      @sta = :success
    end
  end

  def tasks_params
    params.require(:contest).permit( task_ids: [] )[:task_ids]
  end

  def contest_params
    params.require(:contest).permit( :id,
      :name, :grading, :sdate, :edate
    )
  end
end
