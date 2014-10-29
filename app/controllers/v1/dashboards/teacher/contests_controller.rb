class V1::Dashboards::Teacher::ContestsController < V1::BaseController
  include V1::MessageHelper

  def list
    contests = Contest::Info.where("grading = ? and name like ?",
                                   grading, "%#{params[:q]}%").limit(15)
    @sta = contests.size > 0 ? :success : :error
    contests = ActiveModel::ArraySerializer.new(contests, each_serializer: ::Teacher::ContestSerializer)
    render json: {
      msg: cmsg(@sta),
      data: contests
    }
  end

  private

  def grading
    ugroups = Edu::Ugroup.with_role :teacher, current_user
    ugroup = ugroups.find_by(gcode: params[:gcode])
    @grading = ugroup ? ugroup.grading : -1
  end

end
