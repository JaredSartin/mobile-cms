class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :manage, User
      can :manage, App, user_id: user.id
    end
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
