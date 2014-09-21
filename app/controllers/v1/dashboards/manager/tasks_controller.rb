class V1::Dashboards::Manager::TasksController < V1::BaseController
  include V1::MessageHelper
  before_filter :auth
  before_filter :init

  def create
    @task = Task::Info.find_by(tid: task_params[:tid])
    if @task
      @sta = :warning
    else
      create_task
    end
    @err = { error: @task.errors.messages }
    render json: {
      msg: tmsg(@sta, current_user.xrole.name, @err),
      task: @sta == :success ? @task : nil
    }
  end

  def index
    @tasks = Task::Info.all
    aas = ActiveModel::ArraySerializer
    mts = ManagerTaskSerializer
    @tasks = aas.new(@tasks, each_serializer: mts)
    render json: @tasks
  end

  private
  def create_task
    @task = Task::Info.new(task_params)
    choices_params.each do |ch|
      @task.choices << Task::Choice.new(ch)
    end
    tags_params.each do |k, v|
      tl = v.map{|h| h[:text]}.join(",")
      @task.send("#{k.singularize}_list=", tl)
    end
    saved = @task.save
    @sta = saved ? :success : :error
    if saved
      rating_params.each do |h|
        @task.vote_by voter: current_user, vote_scope: "#{h[:key]}_official", vote_weight: h[:value]
      end
    end
  end

  def auth
    authorize! :manage, Task::Info
  end

  def rating_params
    params.require(:task).permit(
      ratings: [:key, :value]
    )[:ratings]
  end

  def tags_params
    params.require(:task).permit(
      opens: [:text], keywords: [:text], klass: [:text]
    )
  end

  def choices_params
    params.require(:task).permit(
      choices: [:index, :content, :answer]
    )[:choices]
  end

  def task_params
    params.require(:task).permit(
      :tid, :title, :body, :explain, :quest, :info,
      :link, :region
    )
  end

  def init
    @sta = :error
  end
end
