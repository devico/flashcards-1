class HomeController < ApplicationController
def index
  card_base = Card.time_came
  @card = card_base[rand(0...card_base.count - 1)]
end
def check
  @card = Card.find_by(id: params[:home][:id_code])
  @users_choice = params[:home][:user_text]
  if @card.original_text.strip == @users_choice.strip
    @card.update(review_date: 3.days.since)
    flash.now[:success] = 'Все верно! Для закрепления повторим через три дня'
  else
    flash.now[:danger] = 'Ошибка, неправильный перевод'
  end
  card_base = Card.time_came
  @card = card_base[rand(0...card_base.count - 1)]
  render 'index'
end
end
