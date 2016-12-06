class HomeController < ApplicationController
  def index
    @card = Card.random.first
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
