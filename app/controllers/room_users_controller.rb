class RoomUsersController < ApplicationController
  before_action :find_room_user, only: %i(show destroy)

  def destroy
    unless @room_user
      flash[:warning] = t "cantdelete"
      redirect_to root_path
    else
      @room_user.destroy
      flash[:success] = t "deleted"
      redirect_to root_path
    end
  end

  def show;  end

  private

  def find_room_user
    @room_user = RoomUser.find_by id: params[:id]
  end

  def room_user_params
    params.require(:room_user).permit :user_id, :room_id
  end
end
