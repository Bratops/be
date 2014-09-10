module Concerns::User::Rolify
  extend ActiveSupport::Concern

  included do
    rolify after_add: :update_roles_count, after_remove: :update_roles_count
    belongs_to :xrole, class_name: "Role", foreign_key: :xrole_id
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
    self.xrole = Role.find_by(name: :admin)
    self.save
  end

  def make_manager!
    self.roles = []
    add_roles [:manager, :teacher, :student, :user]
    self.xrole = Role.find_by(name: :manager)
    self.save
  end

  def make_teacher!
    make_user :teacher
  end

  def make_student!
    make_user :student
  end

  def make_user!
    make_user :user
  end

  private
  def make_user role
    self.roles = []
    self.add_role role
    self.xrole = Role.find_by(name: role)
    self.save
  end

  def update_roles_count(role)
    self.roles_count = self.roles.count
  end
end
