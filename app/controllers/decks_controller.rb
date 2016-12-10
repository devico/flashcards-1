class DecksController < ApplicationController
  def index
    @decks = Deck.belongs_to_current_user(current_user)
  end

  def activate
    user = User.find(params[:user_id])
    user.deck = params[:format]
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
  
  private

  def deck_params
    params.require(:deck).permit(:name, :user_id)
  end
end
