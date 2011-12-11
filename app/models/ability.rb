class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    if user.role? :super_user
      can :manage, :all
    else
      can [:create, :read], Result
    end
  end
end