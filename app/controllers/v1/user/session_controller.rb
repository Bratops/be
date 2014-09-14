class V1::User::SessionController < Devise::SessionsController
  include V1::MessageHelper
  include Devise::Controllers::Helpers
  #skip_before_filter :authenticate_user!, :only => [:create, :new]
  # TODO skip_authorization_check only: [:create, :failure, :show_current_user, :options, :new]
  prepend_before_filter :require_no_authentication, only: [:create]
  skip_before_filter :authenticate_user_from_token!, only: [:create]

  #before_filter :ensure_json_request

  def_param_group :user do
    param :email, String, "Log-in email"
    param :suid, String, "School ID + Student ID"
    param :alias, String, "Alias"
    param :password, String, "Passwords", required: true
  end

  api :POST, "/session", "Create login session by given params"
  param_group :user
  example "
  # Success
    status: :created,
    status: success,
    user: { email: resource.email, auth_token: resource.authentication_token }
  # Fail
    status: 401,
    status: error,
    user: { email: guest, auth_token: resource.authentication_token }
  "
  def create
    # TODO check build_resource
    # build_resource
    ensure_params_exist
    res = resource_class.
      find_for_database_authentication(login_alias: user_params[:login_alias])
    if res
      valid = res.valid_password?(user_params[:password])
      sign_in(res, store: false)
      if valid
        res.reset_authentication_token!
        res.ensure_authentication_token!
        res.save
        render json: {
          user: UserSerializer.new(res).as_json,
          redirect: "dashboard",
          msg: msg(valid)[:msg],
          status: "success",
        }, status: :created
      else
        invalid_login_attempt
      end
    else
      invalid_login_attempt
    end
  end

  def show
    render json: {
      user: UserSerializer.new(current_user).as_json,
      status: "success",
      redirect: "dashboard",
      msg: msg(true)[:msg]
    }, status: 200
  end

  api :DELETE, "/session", "Delete login session"
  param :token, String, "Token generated from session#create"
  example "
    # Success
    status: 204, { message: 'Session deleted.' success: true }
    # Fail
    status: 401, { message: 'Invalid Token.' success: false }
  "
  def destroy
    token = request.headers[ENV["token_key"]]
    resource = resource_class.find_by_authentication_token(token)
    if resource
      resource.reset_authentication_token!
      signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
      render json: {
        msg: msg(true)[:msg],
        status: "success"
      }, status: 200
    else
      render json: {
        msg: msg(false)[:msg],
        status: "error",
        redirect: "landing"
      }, status: 404
    end
  end

  api :GET, "/session/role", "switch current user's current role"
  param :role_id, Integer, "the role based id switch to"
  def role
    oldr = current_user.xrole
    xrole = current_user.roles.find(params[:role_id])
    current_user.xrole = xrole || oldr
    state = "success"
    if !current_user.save
      state = "error"
      logger.error current_user.errors.messages
    end
    render status: 200, json: {
      user: UserSerializer.new(current_user).as_json,
      redirect: "dashboard",
      msg: jmsg(state), status: state,
    }
  end

  protected
  def ensure_json_request
    if request.format != :json
      render status: 406, json: {
        msg: msg(false)[:msg],
        status: "error",
      }
      return
    end
  end

  def user_params
    params.require(:user).permit(:password, :login_alias)
  end

  def ensure_params_exist
    return unless user_params[:login_alias].blank?
    render json: {
      status: "error",
      msg: msg(false)[:msg]
    }, status: 422
  end

  def invalid_login_attempt
    warden.custom_failure!
    render json: {
      status: "error",
      msg: msg(false)[:msg]
    }, status: 401
  end
end
