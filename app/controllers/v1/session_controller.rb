class V1::SessionController < Devise::SessionsController
  include Devise::Controllers::Helpers
  #skip_before_filter :authenticate_user!, :only => [:create, :new]
  # TODO skip_authorization_check only: [:create, :failure, :show_current_user, :options, :new]
  prepend_before_filter :require_no_authentication, :only => [:create]
  respond_to :json
  respond_to :html, only: []
  respond_to :xml, only: []

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
    success: true,
    user: { email: resource.email, auth_token: resource.authentication_token }
  # Fail
    status: 401,
    success: false,
    user: { email: guest, auth_token: resource.authentication_token }
  "
  def create
    # TODO check build_resource
    # build_resource
    ensure_params_exist
    res = resource_class.
      find_for_database_authentication(login_alias: user_params[:login_alias])
    if res
      if res.valid_password?(user_params[:password])
        render json: {
          user: res,
          success: res ? true : false
        }, status: res ? :created : :unauthorized
      else
        invalid_login_attempt
      end
    else
      invalid_login_attempt
    end
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
    resource = resource_class.find_by_authentication_token(request.headers['HTTP_X_AUTH_TOKEN'])
    if resource
      resource.reset_authentication_token!
      signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
      render json: { message: "Session deleted." },
        success: signed_out, status: 204
    else
      render json: { message: "Invalid token." },
        status: 404
    end
  end

  protected
  def ensure_json_request
    if request.format != :json
      render status: 406, json: { message: "The request must be JSON." }
      return
    end
  end

  def user_params
    params.require(:user).permit(:password, :login_alias)
  end

  def ensure_params_exist
    return unless user_params[:login_alias].blank?
    render json: { success: false,
                   message: "missing login parameter"
    }, status: 422
  end

  def invalid_login_attempt
    warden.custom_failure!
    render json: { success: false, message: 'Error with your login or password' }, status: 401
  end
end
