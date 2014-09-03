class ApplicationController < ActionController::API
  # solution_for
  # undefined method `respond_with'
  include ActionController::ImplicitRender
  include ActionController::MimeResponds
  # solution_for
  # https://github.com/thoughtbot/clearance/issues/435
  # Undefined method protect_from_forgery for devise
  include ActionController::RequestForgeryProtection
  # for authentication
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == "application/json"}

  before_filter :authenticate_user_from_token!

  def landing
    render json: {
      status: "success",
      msg: msg("success")[:msg]
    }, status: 200
  end

  protected
  def authenticate_user_from_token!
    login = request.headers[ENV["login_key"]].presence
    token = request.headers[ENV["token_key"]].presence
    # TODO fix to accept normal name account
    user = login && User.find_by(login_alias: login)

    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    if user && Devise.secure_compare(user.authentication_token, token)
      sign_in(user, store: false)
    else
      warden.custom_failure!
      render json: {
        status: "error",
        msg: msg("error")[:msg]
      }, status: 401
    end
  end

  def msg mtype
    { status: mtype,
      msg: {
        body: I18n.t(:body, scope: "application.auth.#{mtype}"),
        title: I18n.t(:title, scope: "application.auth.#{mtype}"),
      }
    }
  end

  def user_info_json
    UserInfoSerializer.new(current_user).to_json
  end
end
