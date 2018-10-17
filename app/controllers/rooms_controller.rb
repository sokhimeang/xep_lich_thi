class RoomsController < ApplicationController
  before_action :find_room, only: %i(show edit update destroy)
  before_action :login_require, only: %i(new create edit update destroy)
  before_action :admin_require, only: %i(new create edit update destroy)

  def new
    @room = Room.new
  end

  def create
    @room = Room.new room_params

    if @room.save
      flash.now[:success] = t "create_success"
      redirect_to @room
    else
      flash.now[:danger] = t "create_failed"
      render :new
    end
  end

  def edit; end

  def update
    if @room.update room_params
      flash.now[:success] = t "updated"
      redirect_to @room
    else
      render :edit
    end
  end

  def index
    @rooms = if params[:term]
               Room.search(params[:term]).paginate page: params[:page],
                 per_page: Settings.room.per_page
             else
               Room.order_by_code.paginate page: params[:page],
                 per_page: Settings.room.per_page
             end
  end

  def show
    if @room
      @users = @room.users
      @room_users = @room.room_users
    else
      flash[:warning] = "Classroom not found"
      redirect_to root_path
    end
  end

  def destroy
    @room_users = @room.room_users
    @room_users.each do |ru|
      UserSubject.find_by(user_id: ru.user_id,
        subject_id: @room.subject_id).destroy
    end
    @room_users.delete_all
    @room.destroy
    flash[:info] = t "deleted"
    redirect_to rooms_path
  end

  private

  def room_params
    params.require(:room).permit :code, :capacity, :subject_id, :term
  end

  def find_room
    @room = Room.find_by id: params[:id]
  end
end
