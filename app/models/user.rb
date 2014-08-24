class User < ActiveRecord::Base
  include Concerns::TokenAuthenticable
  before_save :ensure_login_alias!

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         #:timeoutable, :omniauthable

  structure do
    email "", index: true,
      validates: { format: /\A[^@]+@[^@]+\z/,
                   uniqueness: { :case_sensitive => false } }
    encrypted_password ""
    reset_password_token ""
    reset_password_sent_at :datetime
    remember_created_at :datetime
    current_sign_in_at :datetime
    last_sign_in_at :datetime
    current_sign_in_ip ""
    last_sign_in_ip ""
    sign_in_count 0
    timestamps

    name ""
    suid "", index: true,
      validates: { allow_blank: true, unless: :suid_blank?,
                   format: /\A\w+-{1}\w+\z/,
                   uniqueness: { case_sensitive: false } }
    login_alias "", index: true,
      validates: { allow_blank: false,
                   uniqueness: { :case_sensitive => false } }
    authentication_token "", index: true
  end

  def suid_blank?
    self.suid.blank?
  end

  def ensure_login_alias!
    if self.login_alias.blank?
      self.login_alias = (self.suid.presence || self.email)
    end
  end
end
