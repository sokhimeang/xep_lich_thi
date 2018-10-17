class LoginController < ApplicationController
  before_action :skip, only: %i(new create)

  def new; end

  def create
    user = User.find_by code: params[:session][:code].upcase

    if user&.authenticate(params[:session][:password])
      log_in user
      flash.now[:info] = t ".success"
      redirect_back_or user
    else
      flash.now[:danger] = t ".invalid"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def skip
    return unless logged_in?
    flash.now[:warning] = "You already logged in."
    redirect_to root_path
  end
end
