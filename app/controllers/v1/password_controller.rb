class V1::PasswordController < Devise::SessionsController
  include Devise::Controllers::Helpers
  skip_before_filter :authenticate_user_from_token!, :only => [:request_reset, :reset]

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
  def request_reset
    resource = resource_class.send_reset_password_instructions(resource_params)
    if successfully_sent?(resource)
      render json: {
        console: "request sent",
        info: "The password reset email has been sent.",
      }
    else
      render json: { console: "error",
                     info: "Sorry, we cannot sent email for given request"
      }
    end
  end

  api :PUT, "/password/reset", "Reset current password and force user relogin"
  param :reset_password_token, String, "From request email"
  param :password, String, "New password"
  param :password_confirmation, String, "New password confirmation"
  def reset
    resource = resource_class.reset_password_by_token(resource_params)

    if resource.errors.empty?
      # resource.unlock_access! if unlockable?(resource)
      resource.reset_authentication_token!
      sign_in(resource_name, resource)
      render json: {
        console: "success to reset passwords",
        notify: "Password update successful. Please login again."
      }, status: :temporary_redirect
    else
      render json: {
        console: "fail to reset passwords",
        notify: "Password update failed."
      }, status: :non_authoritative_information
    end
  end
end
