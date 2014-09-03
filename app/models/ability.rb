class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.xrole_named? :admin
      can :manage, :all
    elsif user.xrole_named? :manager
      mamager_ability
    elsif user.xrole_named? :teacher
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
end
