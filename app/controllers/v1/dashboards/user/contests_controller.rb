class V1::Dashboards::User::ContestsController < V1::CacheController
  include V1::MessageHelper
  include V1::User::CurrentContest
  include V1::User::AnsSubmission

  before_filter :setup

  def index
    find_contests
    us = ActiveModel::ArraySerializer.new(@contests, each_serializer: ::Contest::InfSerializer)
    render json: {
      msg: tmsg(@sta, current_user.xrole.name),
      data: us
    }
  end

  private

  def setup
    @sta = :error
  end

  def find_contests
    @contests = current_user.can_do_contests.opening
    @sta = @contests.size > 0 ? :success : :warning
  end
end
