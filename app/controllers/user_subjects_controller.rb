class UserSubjectsController < ApplicationController
  def new
    @user_subject = UserSubject.new
  end

  def create
    @user_subject = UserSubject.new user_subject_params
    if @user_subject.save
      flash[:success] = "Success"
      redirect_to new_user_subject_path
    else
      flash[:warning] = "Failed"
      render :new
    end
  end

  def destroy
    @user_subject = UserSubject.find_by id: params[:id]
    @user_subject.destroy
    flash[:success] = t "deleted"
    redirect_to root_path
  end

  private
  def user_subject_params
    params.require(:user_subject).permit :user_id, :subject_id
  end
end
