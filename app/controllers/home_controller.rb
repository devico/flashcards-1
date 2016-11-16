class HomeController < ApplicationController
  def index
    @card = Card.review_date_earlier_or_equal.random.first
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
