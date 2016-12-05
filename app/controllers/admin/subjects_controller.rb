class Admin::SubjectsController < ApplicationController
  before_action :user_signin
  before_action :find_subject, only: [:show, :edit, :update, :destroy]
  def index
    @subjects = Subject.all
  end

  def show
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      flash[:success] = "Thêm bộ môn thành công"
      redirect_to admin_subjects_path
    else
      flash[:danger] = "Thêm bộ môn thất bại"
      render :new
    end
  end

  def edit
  end

  def update
    if @subject.update_attributes(subject_params)
      flash[:success] = "Cập nhật bộ môn thành công "
      redirect_to admin_subjects_path
    else
      flash[:danger] = "Cập nhật bộ môn thất bại"
      render :edit
    end
  end

  def destroy
    if @subject.destroy
      flash[:success] = "Xóa bộ môn thành công"
      redirect_to admin_subjects_path
    else
      flash[:danger] = "Xóa bộ môn thất bại"
      redirect_to admin_subjects_path
    end
  end

  private
  def subject_params
    params.require(:subject).permit(:name, :description, :department_id)
  end

  def find_subject
    @subject = Subject.find_by(id: params[:id])
  end
end
