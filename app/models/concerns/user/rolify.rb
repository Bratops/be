module Concerns::User::Rolify
  extend ActiveSupport::Concern

  include do
  end

  module ClassMethods
    def user_rolify
      rolify after_add: :update_roles_count, after_remove: :update_roles_count
    end
  end

  def current_role? role
    self.xrole_id == role.id
  end

  def role_named? role
    !self.xrole.nil? && (self.xrole.name == role.to_s)
  end

  def has_many_roles?
    self.roles.count > 1
  end

  def add_roles roles
    roles.each do |ro|
      self.add_role ro
    end
  end

  def make_admin!
    self.roles = []
    add_roles [:admin, :manager, :teacher, :student, :user]
    self.save
  end

  def make_manager!
    self.roles = []
    add_roles [:manager, :teacher, :student, :user]
    self.save
  end

  def make_teacher!
    self.roles = []
    self.add_role :teacher
    self.save
  end

  def make_student!
    self.roles = []
    self.add_role :student
    self.save
  end
  private
  def update_roles_count(role)
    self.roles_count = self.roles.count
  end
end
