class HomeController < ApplicationController

  def index
    @card = Card.review_date_earlier_or_equal.pick_rand
  end

  def check
        result = CheckTranslation.call(
      users: params[:home][:user_text],
      card_id: params[:home][:id_code]
    )

    flash[result.key] = result.notice
    redirect_to action: "index"
  end
end
