class V1::Dashboards::Manager::UsersController < V1::BaseController
  include V1::MessageHelper
  def list
    authorize! :list, User
    data = load_user params[:kind]
    render status: 200, json: data
  end

  def approve
    u = User.find(params[:id])
    authorize! :manage, u
    sta = "error"
    if u.is_teacher_applicant
      u.make_teacher!
      sc = u.ugroups.find_by(name: "alumnus").school
      sc.add_teacher u
      sta = "success"
      SessionMailer.create(u).deliver
    end
    render json: {
      msg: tmsg(sta, current_user.xrole.name),
    }
  end

  private

  def load_user role
    user = User.with_role(role)
    data = user.where("user_id != ?", current_user.id).
        paginate(page: params[:page], per_page: params[:per_page])
    data = ActiveModel::ArraySerializer.new(data, each_serializer: UserInfoSerializer)
    {
      users: data,
      total: user.count - 1
    }
  end

end
