class LoginController < ApplicationController
  def new
  end

  def create
    user = User.find_by code: params[:session][:code].upcase

    if user&.authenticate(params[:session][:password])
      log_in user
      flash[:info] = t ".success"
      redirect_to "/users/#{user.id}"
    else
      flash[:danger] = t ".invalid"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
