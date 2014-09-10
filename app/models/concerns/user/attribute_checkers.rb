module Concerns::User::AttributeCheckers
  extend ActiveSupport::Concern

  included do
    before_create :ensure_login_alias!
    after_create :ensure_xrole!
  end

  def ensure_login_alias!
    if self.login_alias.blank?
      self.login_alias = (self.suid.presence || self.email)
    end
  end

  def provider_blank?
    self.provider.blank?
  end

  def suid_blank?
    self.suid.blank?
  end

  def ensure_xrole!
    self.add_role :user
    self.xrole_id = self.roles.find_by(name: "user").id
    self.save
  end
end
