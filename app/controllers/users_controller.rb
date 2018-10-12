class UsersController < ApplicationController
  before_action :find_user, only: %i(show edit update destroy)

  def register_subjects; end

  def do_register_subjects
    @user = User.find_by id: 1
    @subjects = Subject.all
    ktra = false

    @subjects.each do |subject|
      next unless subject.code == params[:term]
      user_id = @user.id
      subject_id = subject.id
      @user_subject = UserSubject.new(user_id: user_id,
        subject_id: subject_id)
      @user_subject.save
      ktra = true
      flash[:success] = "Successfully register ..."
      redirect_to @user
    end
    return if ktra
    flash[:danger] = "Error ... Check and Fill in again carefully"
    render :register_subjects
  end

  def register_room; end

  def do_register_room
    @user = User.find_by id: 1
    @rooms = Room.all
    ktra = false

    @rooms.each do |room|
      if (room.code == params[:term])
        @room_user = RoomUser.new(room_id: room.id,
          user_id: @user.id)
        @room_user.save
        ktra = true
        flash[:success] = "Successfully register ..."
        redirect_to @user
      end
    end
    unless ktra
      flash[:danger] = "Error ... Check and Fill in again carefully"
      render :register_room
    end
  end

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

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "updated"
      redirect_to users_path
    else
      render :edit
    end
  end

  def show
    # @subjects = @user.subjects
    @rooms = @user.rooms
    @room_users = @user.room_users
  end

  def index
    @users = if params[:term]
               User.search(params[:term]).paginate page: params[:page],
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
