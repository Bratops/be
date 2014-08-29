class V1::PasswordController < Devise::SessionsController
  include Devise::Controllers::Helpers
  include V1::FrontendHelper
  skip_before_filter :authenticate_user_from_token!, :only => [:request_link, :reset]

  resource_description do
    api_versions "1.0"
    short "Passwords reset request handler"
  end

  def mail_test
    PasswordMailer.test.deliver
    render json: { console: "ok"}, status: 200
  end

  api :POST, "/password/forget", "Post a request for asking reset password email."
  param :login_alias, String, "Email or suid"
  see link: "registration#create", desc: "User registration parameter settings"
  def request_link
    ret = false
    resource = resource_class.find_by_alias(params[:login_alias]).first
    if resource
      resource = resource_class.send_reset_password_instructions(resource)
      ret = successfully_sent?(resource)
    end
    render json: {
      status: ret ? "success" : "error",
      redirect: (ret ? "landing" : ""),
      msg: msg(ret)[:msg],
    }, status: (ret ? 200 : :non_authoritative_information)
  end

  api :PUT, "/password/reset", "Reset current password and force user relogin"
  param :reset_password_token, String, "From request email"
  param :password, String, "New password"
  param :password_confirmation, String, "New password confirmation"
  def reset
    resource = resource_class.reset_password_by_token(reset_params)
    ret = resource.errors.empty?
    if ret
      # resource.unlock_access! if unlockable?(resource)
      resource.reset_authentication_token!
      resource.ensure_authentication_token!
      resource.save
      sign_in(resource_name, resource)
    end
    render json: {
      status: ret ? "success" : "error",
      user: ret ? UserSerializer.new(resource).as_json : nil,
      redirect: (ret ? "dashboard" : ""),
      msg: msg(ret)[:msg],
    }, status: (ret ? 200 : :non_authoritative_information)
  end

  protected
  def reset_params
    params.permit(:reset_password_token, :password, :password_confirmation)
  end
end
