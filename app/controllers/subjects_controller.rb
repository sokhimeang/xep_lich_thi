class SubjectsController < ApplicationController
  before_action :find_subject, only: %i(edit update show destroy)

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new subject_params

    if @subject.save
      flash[:success] = t "create_success"
      redirect_to @subject
    else
      flash[:danger] = t "create_failed"
      render :new
    end
  end

  def edit; end

  def update
    if @subject.update subject_params
      flash[:success] = t "updated"
      redirect_to subjects_path
    else
      render :edit
    end
  end

  def show; end

  def index
    @subjects = if params[:term]
      Subject.where('code LIKE ? OR name LIKE ?',
        "%#{params[:term]}%", "%#{params[:term]}%").paginate page: params[:page],
        per_page: Settings.subject.per_page
    else
      @subjects = Subject.order_by_code.paginate page: params[:page],
        per_page: Settings.subject.per_page
    end
  end

  def destroy
    @subject.destroy
    flash[:success] = t "deleted"
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
