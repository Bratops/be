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
    en = current_user.nondone_enrolls.first
    @grading = en ? en.ugroup.grading : -1
    @contestable = true #en ? en.contestable : false
  end

  def find_contests
    @contests = []
    if @contestable
      @sta = :success
      @contests = Contest::Info.where(grading: @grading).opening
    else
      @sta = :warning
    end
  end
end
