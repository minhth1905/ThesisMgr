class Admin::TrainingsController < ApplicationController
  before_action :user_signin
  before_action :find_training, only: [:show, :edit, :update, :destroy]
  def index
    @trainings = Training.all
  end

  def show
  end

  def new
    @training = Training.new
  end

  def create
    @training = Training.new(training_params)
    if @training.save
      flash[:success] = "Thêm chương trình đào tạo thành công"
      redirect_to admin_trainings_path
    else
      flash[:danger] = "Thêm chương trình đào tạo thất bại"
      render :new
    end
  end

  def edit
  end

  def update
    if @training.update_attributes(training_params)
      flash[:success] = "Cập nhật chương trình đào tạo thành công"
      redirect_to admin_trainings_path
    else
      flash[:danger] = "Cập nhật chương trình đào tạo thất bại"
      render :edit
    end
  end

  def destroy
    if @training.destroy
      flash[:success] = "Xóa chương trình đào tạo thành công"
      redirect_to admin_trainings_path
    else
      flash[:danger] = "Xóa chương trình đào tạo thất bại"
      redirect_to admin_trainings_path
    end
  end

  private
  def training_params
    params.require(:training).permit(:name, :description, :course_id)
  end

  def find_training
    @training = Training.find_by(id: params[:id])
  end
end
