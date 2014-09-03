module Concerns::User::Rolify
  extend ActiveSupport::Concern

  include do
  end

  module ClassMethods
    def user_rolify
      rolify after_add: :update_roles_count, after_remove: :update_roles_count
      before_create :add_user_role!
    end
  end

  def current_role? role
    self.xrole_id == role.id
  end

  def xrole_named? role_name
    !self.xrole.nil? && self.xrole.name == role.to_s
  end

  def has_many_roles?
    self.roles.count > 1
  end

  private
  def add_user_role!
    self.add_role :user
  end

  def update_roles_count(role)
    self.roles_count = self.roles.count
  end
end
