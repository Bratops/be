class Ability
  include CanCan::Ability

  def initialize(user, controller_namespace)
    user ||= User.new # guest user (not logged in)
    case controller_namespace
    when "V1::Dashboards::Admin"
      scope_admin_abilities user
    when "V1::Dashboards::Manager"
      scope_manager_abilities user
    when "V1::Dashboards::Teacher"
      scope_teacher_abilities user
    when "V1::Dashboards::User"
      scope_user_abilities user
    else
      general_abilities user
    end
  end

  private
  def scope_admin_abilities user
    if user.role_named? :admin
      can :manage, :all
    end
  end

  def scope_manager_abilities user
    if user.role_named? :manager
      has_manager_ability
    end
  end

  def scope_teacher_abilities user
    if user.role_named? :teacher
      has_teacher_ability_for user
    end
  end

  def scope_user_abilities user
    return unless user.role_named? :user
    can :join, Edu::Ugroup
  end

  def general_abilities user
    if user.role_named? :admin
      can :manage, :all
    else
      can :read, Menu.with_role(user.xrole.name)
      can :read, Msg
      can :read, :landing
    end
  end

  def has_manager_ability
    can :manage, Msg
    can :list, User
    can :manage, User.with_role(:student)
    can :manage, User.with_role(:teacher)
    can :manage, User.with_role(:teacher_applicant)
    can :manage, Task::Info
    can :manage, Contest
    can :manage, SysFile
  end

  def has_teacher_ability_for(user)
    can :create, Edu::Ugroup
    can :manage, Edu::Ugroup, id: Edu::Ugroup.with_role(:teacher, user).pluck(:id)
  end

  def namespace
    controller_name_segments = params[:controller].split("/")
    controller_name_segments.pop
    controller_namespace = controller_name_segments.join("/").camelize
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, namespace)
  end
end

