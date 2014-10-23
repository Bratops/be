module Concerns::TokenAuthenticable
  extend ActiveSupport::Concern

  included do
    before_save :ensure_authentication_token!
  end

  module ClassMethods
    def reset_authentication_token!
      self.authentication_token = generate_authentication_token
      self.save
    end
  end

  def reset_pass
    raw, enc = Devise.token_generator.generate(self.class, :reset_password_token)
    self.reset_password_token   = enc
    self.reset_password_sent_at = Time.now.utc
    self.save(validate: false)
    raw
  end

  # TODO combined with device info
  def ensure_authentication_token!
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def generate_authentication_token
    loop do
      token = generate_secure_token_string
      break token unless self.class.exists?(authentication_token: token)
    end
  end

  def generate_secure_token_string
    SecureRandom.urlsafe_base64(25).tr('lIO0', 'sxyz')
  end

  # Sarbanes-Oxley Compliance: http://en.wikipedia.org/wiki/Sarbanes%E2%80%93Oxley_Act
  def password_complexity
    return nil
    if password.present? and not password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W]).+/)
      errors.add :password, "must include at least one of each: lowercase letter, uppercase letter, numeric digit, special character."
    end
  end

  def password_presence
    password.present? && password_confirmation.present?
  end

  def password_match
    password == password_confirmation
  end
end
