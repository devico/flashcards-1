class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can [:read, :create, :activate], [Card, Deck]
    can [:update, :destroy], [Card, Deck], user_id: user.id
  end
end
