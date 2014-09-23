module Concerns::User::AttributeCheckers
  extend ActiveSupport::Concern

  included do
    before_create :ensure_login_alias!
    after_create :ensure_xrole!

    has_one :info, class_name: "Acn::Info",
      dependent: :destroy
    scope :find_by_alias, ->(ali){where(login_alias: ali)}
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

  def uname
    if self.info
      self.info.name
    else
      "no name"
    end
  end
end
