class ApplicationController < ActionController::API
  # solution_for
  # undefined method `respond_with'
  include CanCan::ControllerAdditions
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

  include V1::MessageHelper
  def landing
    render json: {
      status: "success",
      msg: msg(true)[:msg]
    }, status: 200
  end

  protected
  def authenticate_user_from_token!
    login = request.headers[ENV["login_key"]].presence
    token = request.headers[ENV["token_key"]].presence
    user = login && User.find_by(login_alias: login)

    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    if user && Devise.secure_compare(user.authentication_token, token)
      sign_in(user, bypass: true)
      #just pass here
    else
      warden.custom_failure!
      render json: ad_msg(), status: 401
    end
  end

  def user_info_json
    ::User::InfoSerializer.new(current_user).to_json
  end

  private
  def current_ability
    controller_name_segments = params[:controller].split('/')
    controller_name_segments.pop
    controller_namespace = controller_name_segments.join('/').camelize
    Ability.new(current_user, controller_namespace)
  end

  rescue_from CanCan::AccessDenied do |ex|
    bk = ex.backtrace[0]
    mssg = "Access denied on #{bk} \n at ##{ex.action} with User: #{current_user.id}, #{current_user.email}"
    Rails.logger.info mssg
    ExceptionNotifier.notify_exception(ex, env: request.env, data: {message: mssg})
    render status: :forbidden, json: ad_msg()
  end
end

