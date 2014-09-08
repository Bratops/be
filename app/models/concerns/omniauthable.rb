module Concerns::Omniauthable
  extend ActiveSupport::Concern
  module ClassMethods
    def from_omniauth(auth)
      find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
        user.email = auth.info.email || "#{auth.uid}@#{auth.provider}.uid"
        pk = Devise.friendly_token[0,20]
        user.password = pk
        user.password_confirmation = pk
      end
    end

    # update session for registration, for omniauth gem
    def new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.oauth_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end
  end
end
