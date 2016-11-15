class HomeController < ApplicationController

def index
  @card = Card.review_date_earlier_or_equal.pick_rand
end

def check

card_check = Card.find_by(id: params[:home][:id_code])

result = CheckTranslation.call(
original: params[:home][:user_text],
users: card_check.original_text,
card: card_check)

if result.success?
  flash.now[:success] = 'Все верно! Для закрепления повторим через три дня'
else
  flash.now[:danger] = 'Ошибка, неправильный перевод'
end

@card = Card.review_date_earlier_or_equal.pick_rand
render 'index' 
end
end
