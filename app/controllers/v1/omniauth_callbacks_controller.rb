class V1::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include V1::FrontendHelper
  include V1::DeviseJsonAdapter

  skip_before_filter :authenticate_user_from_token!

  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    user = User.from_omniauth(request.env["omniauth.auth"])
    render json: post_auth(user), status: :created
  end

  def google
    user = User.from_omniauth(request.env["omniauth.auth"])
    render json: post_auth(user), status: :created
  end

  protected
  def post_auth user
    login = user.persisted?
    if login
      user.ensure_authentication_token!
      sign_in(user, store: false)
    else
      session["devise.auth_data"] = request.env["omniauth.auth"]
    end
    {
      user: UserSerializer.new(user).as_json,
      redirect: login ? "dashboard" : "register",
      msg: msg(login)[:msg],
      status: login ? "success" : "error",
    }
  end
end
