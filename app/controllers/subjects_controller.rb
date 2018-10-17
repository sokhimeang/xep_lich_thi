class SubjectsController < ApplicationController
  before_action :find_subject, only: %i(edit update show destroy)
  before_action :login_require, only: %i(new create edit update destroy)
  before_action :admin_require, only: %i(new create edit update destroy)

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new subject_params

    if @subject.save
      flash.now[:success] = t "create_success"
      redirect_to @subject
    else
      flash.now[:danger] = t "create_failed"
      render :new
    end
  end

  def edit; end

  def update
    if @subject.update subject_params
      flash.now[:success] = t "updated"
      redirect_to @subject
    else
      render :edit
    end
  end

  def show
    @rooms = @subject.rooms
  end

  def index
    @subjects = if params[:term]
                  Subject.search(params[:term]).paginate page: params[:page],
                    per_page: Settings.subject.per_page
                else
                  @subjects = Subject.order_by_code.paginate page:
                    params[:page], per_page: Settings.subject.per_page
                end
  end

  def destroy
    @subject.destroy
    flash.now[:success] = t "deleted"
    redirect_to subjects_url
  end

  private
  def subject_params
    params.require(:subject).permit :code, :name, :exam_during, :term
  end

  def find_subject
    @subject = Subject.find_by id: params[:id]
  end
end
