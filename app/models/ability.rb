class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    alias_action :index, :show, :to => :read
    alias_action :new, :to => :create
    can [:read, :create, :activate], [Card, Deck]
    can [:update, :destroy], [Card, Deck], :user_id => user.id    
  end
end
