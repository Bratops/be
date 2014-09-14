class V1::Dashboards::Manager::UsersController < V1::BaseController
  include V1::MessageHelper
  before_filter :authorize_user, except: [:list]

  def list
    authorize! :list, User
    data = load_user params[:kind]
    render status: 200, json: data
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

  def authorize_user
    authorize! :manage, User
  end
end
