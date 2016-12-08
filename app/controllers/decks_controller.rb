class DecksController < ApplicationController
  def index
    @decks = Deck.belongs_to_current_user(current_user)
  end
end
