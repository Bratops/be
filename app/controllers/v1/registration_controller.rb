class V1::RegistrationController < Devise::RegistrationsController
  include V1::FrontendHelper
  resource_description do
    short "Registration"
    desc <<-EOS
      Provide single registration interface
    EOS
    api_versions "1.0"
    formats ["json"]
  end

  # TODO skip_authorization_check only: [:create, :failure, :show_current_user, :options, :new]
  skip_before_filter :verify_authenticity_token, if: :json_request?
  skip_before_filter :authenticate_scope!, only: [ :destroy ]
  before_filter :authenticate_user_from_token!, only: [ :destroy ]

  def_param_group :user do
    param :email, String, "Log-in email"
    param :suid, String, "School ID + Student ID"
    param :login_alias, String, "Alias"
    param :password, String, "Passwords", required: true
    param :password_confirmation, String, "Double check input passwords", required: true
  end

  api :POST, "/user", "Register new user by given params"
  error code: 422, desc: "Unprocessalbe entity"
  param_group :user
  meta message: "TODO Add example"
  def create
    resource = resource_class.new(user_params)
    update_resource(resource)
    # resource.skip_confirmation!  # must be confirmable
    ret = resource.save
    if ret
      resource = resource_class.send_reset_password_instructions(resource)
      sign_in(resource, store: false)
    else
      warden.custom_failure!
    end
    render status: ret ? 200 : :unprocessable_entity,
      json: {
      status: ret ? "success" : "error",
        user: ret ? UserSerializer.new(resource).as_json : nil,
        redirect: ret ? "dashboard" : "",
        msg: msg(ret)[:msg]
    }
  end

  api :DELETE, "/user", "Delete a user by given params"
  error code: 401, desc: "Unauthorized"
  error code: 404, desc: "Not Found"
  param :suid, String, "School ID + Student ID"
  meta message: "TODO add authorization"
  def destroy
    resource = send(:"current_#{resource_name}")
    if resource
      resource.destroy
      Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    end
    render json: {
      status: resource ? "success": "error",
      msg: msg(resource ? true : false)[:msg]
    }, status: :unauthorized
  end

  private
  def user_params
    params.require(:user).permit( :email, :suid, :login_alias)
  end

  def json_request?
    request.format.json?
  end

  def user_info_params
    params.require(:user).permit(:name, :phone)
  end

  def school_params
    params.require(:user).permit(:moeid)
  end

  def update_resource(resource)
    rk = resource.generate_secure_token_string
    resource.password = rk
    resource.password_confirmation = rk
    resource.login_alias = resource.email.presence || "#{school_params["moeid"]}-#{resource.suid}"
    resource.user_info = UserInfo.mock(user_info_params)
    sa = School.find_by(school_params).alumnus
    sa.users << resource
    if sa.save
      if params[:user][:as_teacher]
        resource.add_role :teacher_applicant
      end
      return resource
    else
      return nil
    end
  end
end
