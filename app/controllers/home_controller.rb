class HomeController < ApplicationController
  def index
    if Deck.exists?(id: current_user.deck_id)
      deck = Deck.find(current_user.deck_id)
      @status = 'Карточки из колоды ' + deck.name
      @card = Card.from_active_deck(current_user).review_date_earlier_or_equal.random.first
    else
      @status = 'Колода не выбрана, показываем случайные карточки'
      @card = Card.review_date_earlier_or_equal.random.first
    end
  end

  def check
    result = CheckTranslation.call(
      users: params[:home][:user_text],
      card_id: params[:home][:id_code]
      )
    flash[:notice] = result.notice
    redirect_to action: "index"
  end
end
