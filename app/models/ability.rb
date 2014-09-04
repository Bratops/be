class Ability
  include CanCan::Ability

  def initialize(user, controller_namespace)
    user ||= User.new # guest user (not logged in)
    case controller_namespace
    when "admin"
      scope_admin_abilities user
    when "manager"
      scope_manager_abilities user
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

  def general_abilities user
    if user.role_named? :admin
      can :manage, :all
    elsif user.role_named? :manager
      mamager_ability
    elsif user.role_named? :teacher
      teacher_ability
    else
      can :read, :landing
    end
  end

  def manager_ability
    can :read, Menu.with_role(:manager)
  end

  def teacher_ability
    can :read, Menu.with_role(:teacher)
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

