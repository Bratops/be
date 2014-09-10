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
    scope_admin_abilities user
    if user.role_named? :manager
      can :manage, :all
    end
  end

  def scope_teacher_abilities user
    if user.role_named? :teacher
      has_teacher_ability_for user
    end
  end

  def general_abilities user
    if user.role_named? :admin
      can :manage, :all
    else
      can :read, Menu.with_role(user.xrole.name)
      can :read, :landing
    end
  end

  def manager_ability
  end

  def has_teacher_ability_for(user)
    can :create, Ugroup
    can :manage, Ugroup, id: Ugroup.with_role(:teacher, user).pluck(:id)
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

