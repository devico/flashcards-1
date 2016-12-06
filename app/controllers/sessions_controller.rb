class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  def new
  end

  def create
    if login(params[:email], params[:password])
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to log_in_path
  end
end
