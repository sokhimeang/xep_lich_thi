class UsersController < ApplicationController
  before_action :find_user, only: %i(show edit update destroy)

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:info] = t "create_success"
      redirect_to @user
    else
      flash[:danger] = t "create_failed"
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update user_params
      flash[:success] = t "updated"
      redirect_to users_path
    else
      render :edit
    end
  end

  def show
    @subjects = @user.subjects
  end

  def index
    @users = if params[:term]
      User.where('code LIKE ? OR name LIKE ?', "%#{params[:term]}%",
        "%#{params[:term]}%").paginate page: params[:page],
        per_page: Settings.user.account.per_page
    else
      User.order_by_code.paginate page: params[:page],
        per_page: Settings.user.account.per_page
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t "deleted"
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit :code, :name, :email,
      :password, :password_confirmation, :image, :term
  end

  def find_user
    @user = User.find_by id: params[:id]
  end
end
