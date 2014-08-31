class V1::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include V1::FrontendHelper
  include V1::DeviseJsonAdapter

  skip_before_filter :authenticate_user_from_token!
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    user = User.from_omniauth(request.env["omniauth.auth"])
    login = user.persisted?
    if login
      sign_in(user, store: false)
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
    end
    render json: {
      user: UserSerializer.new(user).as_json,
      redirect: login ? "dashboard" : "register",
      msg: msg(login)[:msg],
      status: login ? "success" : "error",
    }, status: :created
  end

  def callback
    auth = request.env['omniauth.auth']
    logger.debug "Auth variable: #{auth.inspect}"

    # Try to find authentication first
    authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])

    unless current_user
      # Request a new 60 day token using the current 2 hour token obtained from fb
      auth.merge!(extend_fb_token(auth['credentials']['token']))
      authentication.update_attribute("token", auth['extension']['token']) if authentication

      unless authentication
        user = User.new
        user.apply_omniauth(auth)
        saved_status = user.save(:validate => false)
      end

      # Add the new token and expiration date to the user's session
      create_or_refresh_fb_session(auth)
      if saved_status.nil? || saved_status
        user = authentication ? authentication.user : user
        sign_in(:user, user)
      end
    end

    render :json => { :success => (current_user ? true : false),
                      :current_user => current_user.as_json(:only => [:email]) }
  end
end
