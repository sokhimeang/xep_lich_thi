class RoomUsersController < ApplicationController
  before_action :find_room_user, only: %i(show destroy)
  before_action :login_require, only: %i(new create destroy)
  before_action :admin_require, only: %i(new create destroy)

  def new
    @room_user = RoomUser.new
  end

  def create
    @room = Room.find_by code: params[:room_code]
    @user = User.find_by code: params[:user_code]
    if @room && @user
      new_room_user(@user.id, @room.id, @room.subject_id)
    else
      flash.now[:danger] = t "create_failed"
      render :new
    end
  end

  def destroy
    if @room_user
      user_id = @room_user.user_id
      room_id = @room_user.room_id
      subject_id = Room.find_by(id: room_id).subject_id
      @user_subject = UserSubject.find_by(user_id: user_id,
        subject_id: subject_id)
      @user_subject.destroy
      @room_user.destroy
      flash.now[:success] = t "deleted"
    else
      flash.now[:warning] = t "cantdelete"
    end
    redirect_to root_path
  end

  def show; end

  private

  def find_room_user
    @room_user = RoomUser.find_by id: params[:id]
  end

  def room_user_params
    params.require(:room_user).permit :user_id, :room_id,
      :user_code, :room_code
  end

  def new_room_user user_id, room_id, subject_id
    @user_subject = UserSubject.new(
      user_id: user_id,
      subject_id: subject_id
    )
    return unless @user_subject.save
    @room_user = RoomUser.new(
      user_id: user_id,
      room_id: room_id
    )
    @room_user.save
    flash[:notice] = t "create_success"
    redirect_to new_room_user_path
  end
end
