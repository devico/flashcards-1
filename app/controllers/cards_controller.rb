class CardsController < ApplicationController

  load_and_authorize_resource :except => :create

  def index
    @cards = Card.belongs_to_current_user(current_user)
  end

  def new
    @status = 'hide'
    @decks = Deck.belongs_to_current_user(current_user)
  end

  def edit
    @status = 'hide'
    @card = Card.find(params[:id])
  end

  def update
    @card = Card.find(params[:id])
    @card.update(card_params)
    if @card.save
      redirect_to cards_path
    else
      @message = 'Bce поля обязательны для заполнения, оригинал и перевод должны отличаться'
      @status = 'show'
      render 'edit'
    end
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      redirect_to cards_path
    else
      @message = 'Bce поля обязательны для заполнения, оригинал и перевод должны отличаться'
      @status = 'show'
      render 'new'
    end
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy
    redirect_to cards_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to cards_path
  end
  
  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :user_id, :image, :remote_image_url, :deck_id)
  end
end
