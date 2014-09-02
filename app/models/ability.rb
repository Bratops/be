class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.current_role? :admin
      can :manage, :all
    else
      can :read, :all
    end
  end
end
