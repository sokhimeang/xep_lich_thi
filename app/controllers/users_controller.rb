class UsersController < ApplicationController
  before_action :find_user, only: %i(show edit update destroy)

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:info] = t ".create"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def show
  end

  def index
    @users = User.order_by_code.paginate page: params[:page],
      per_page: Settings.user.account.per_page
  end

  def destroy
    @user.destroy
    flash[:success] = t "delete"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit :code, :name, :email,
      :password, :password_confirmation
  end

  def find_user
    @user = User.find_by id: params[:id]
  end
end
