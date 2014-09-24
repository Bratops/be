class V1::Dashboards::Admin::UsersController < V1::BaseController
  before_filter :authorize_user

  def index
    users = User.where("id != ?", current_user.id).
      paginate(page: 1, per_page: 30)
    user_json = ActiveModel::ArraySerializer.new(users, each_serializer: UserInfoSerializer)
    render status: 200, json: {
      data: user_json
    }
  end

  def authorize_user
    authorize! :manage, User
  end
end
