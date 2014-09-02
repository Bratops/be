module Concerns::User::AttributeCheckers
  extend ActiveSupport::Concern
  include do
    before_save :ensure_login_alias!
  end

  def provider_blank?
    self.provider.blank?
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
