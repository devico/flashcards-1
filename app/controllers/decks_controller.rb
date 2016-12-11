class DecksController < ApplicationController

  load_and_authorize_resource :except => :create

  def index
    @decks = Deck.belongs_to_current_user(current_user)
  end

  def activate
    user = User.find(params[:user_id])
    user.deck_id = params[:format]
    user.save(validate: false)
    redirect_to decks_path
  end

  def new
  end

  def create
    @deck = Deck.new(deck_params)
    if @deck.save
      redirect_to decks_path
    else
    end
  end

  def destroy
    deck = Deck.find(params[:id])
    deck.destroy
    redirect_to decks_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to decks_path
  end
  
  private

  def deck_params
    params.require(:deck).permit(:name, :user_id)
  end
end
