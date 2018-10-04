class RoomsController < ApplicationController
  before_action :find_room, only: %i(show edit update destroy)

  def new
    @room = Room.new
  end

  def create
    @room = Room.new room_params

    if @room.save
      flash[:success] = t "create_success"
      redirect_to rooms_path
    else
      flash[:danger] = t "create_failed"
      render :new
    end
  end

  def edit; end

  def update
    if @room.update room_params
      flash[:success] = t "updated"
      redirect_to rooms_path
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

  def show; end

  def destroy
    @room.destroy
    flash[:info] = t "deleted"
    redirect_to rooms_path
  end

  private

  def room_params
    params.require(:room).permit :code, :capacity, :term
  end

  def find_room
    @room = Room.find_by id: params[:id]
  end
end
