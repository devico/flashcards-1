class HomeController < ApplicationController
  def index
    result = NominateCards.call(
      user: current_user
    )
    @status = result.status
    @card = result.card
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
