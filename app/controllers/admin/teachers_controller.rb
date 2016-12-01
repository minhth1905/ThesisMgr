class Admin::TeachersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def new
    @teacher = Teacher.new
  end

  def create
    render text: params[:firstname]
  end


  def import
    User.import(params[:file])
    Teacher.import(params[:file])
    redirect_to admin_teachers_path, notice: "Products imported."
  end

  private
  def teacher_params
    params.require(:course).permit(:name)
  end
end
