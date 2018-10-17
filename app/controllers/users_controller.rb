class UsersController < ApplicationController
  before_action :find_user, only: %i(show edit update destroy)
  before_action :login_require, only: %i(new create edit update register_room
    do_register_room)
  before_action :admin_require, only: %i(new create destroy)
  before_action :correct_user, only: %i(edit update)
  before_action :current_user, only: %i(register_room do_register_room)

  # def register_subjects; end
  #
  # def do_register_subjects
  #   @user = User.find_by id: 1
  #   @subjects = Subject.all
  #   ktra = false
  #
  #   @subjects.each do |subject|
  #     next unless subject.code == params[:term]
  #     user_id = @user.id
  #     subject_id = subject.id
  #     @user_subject = UserSubject.new(user_id: user_id,
  #       subject_id: subject_id)
  #     @user_subject.save
  #     ktra = true
  #     flash.now[:success] = "Successful register ..."
  #     redirect_to @user
  #   end
  #   return if ktra
  #   flash.now[:danger] = "Error ... Check and Fill in again carefully"
  #   render :register_subjects
  # end

  def register_room; end

  def do_register_room
    @room = Room.find_by code: params[:term]
    @ktra = true
    if @room
      if @room.users.count < @room.capacity
        user_id = @current_user.id
        new_subject(user_id, @room.subject_id, @room.id)
      else
        full_clash
      end
    else
      not_found
    end

    return if @ktra
    registered_warning
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash.now[:info] = t "create_success"
      redirect_to @user
    else
      flash.now[:danger] = t "create_failed"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "updated"
      redirect_to @user
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

  # need checking logged_in first
  def correct_user
    @user = User.find_by id: params[:id]
    return if current_user?(@user)
    flash[:warning] = "Not your account, check information again"
    redirect_to root_url
  end

  def new_subject user_id, subject_id, room_id
    @user_subject = UserSubject.new(
      user_id: user_id,
      subject_id: subject_id
    )
    if @user_subject.save
      @room_user = RoomUser.new(room_id: room_id,
        user_id: user_id)
      @room_user.save
      flash[:success] = "Successfully register ..."
      redirect_to register_room_path
    else
      @ktra = false
    end
  end

  def full_clash
    flash.now[:warning] = "(Capacity) Class full"
    render :register_room
  end

  def not_found
    flash.now[:warning] = "Cannot find room code"
    render :register_room
  end

  def registered_warning
    flash.now[:danger] = t ".registered_subject"
    render :register_room
  end
end
