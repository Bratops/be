class V1::User::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include V1::FrontendHelper
  include V1::DeviseJsonAdapter

  skip_before_filter :authenticate_user_from_token!

  def facebook
    # todo check invalid user (id nil)
    user = User.from_omniauth(request.env["omniauth.auth"])
    render json: post_auth(user, "facebook"), status: :created
  end

  def google
    user = User.from_omniauth(request.env["omniauth.auth"])
    json = post_auth(user, "google")
    jqr = { key: user.authentication_token, login: user.login_alias,
            role: user.xrole.name, role_id: user.xrole.id
    }
    redirect_to "http://#{ENV["host_current_front"]}/gauth?#{jqr.to_query}"
    #render json: , status: :created
  end

  def failure
    puts failure_message
    render status: 200, json: {
      msg: msg(false)[:msg],
      redirect: "landing",
      status: "error"
    }
  end

  protected

  def post_auth user, provider
    login = user.persisted?
    if login
      user.ensure_authentication_token!
      sign_in(user, store: false)
    else
      session["devise.oauth_data"] = request.env["omniauth.auth"]
    end
    {
      user: UserSerializer.new(user).as_json,
      redirect: login ? "dashboard" : "register",
      msg: msg(login)[:msg],
      status: login ? "success" : "error",
    }
  end
end
