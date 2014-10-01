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
      key = "contest_#{params[:id]}"
      @contest = cache_with key, expires_in: 3.day do
        Contest::Info.find_by(id: params[:id], grading: @grading)
      end
    end
    render json: ::User::Contest::DoSerializer.new(@contest)
  end

  private

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
