class StudentsController < ApplicationController
  before_action :user_signin
  def show
  end
  def edit
    @user = User.find_by(id: params[:id])
    @student = Student.find_by(user_id: @user.id)
  end
  def update
    @user = User.find_by(id: params[:id])
    @student = Student.find_by(user_id: @user.id)
    if @user.update_attributes(first_name: params[:first_name],
     last_name: params[:last_name], birthday: params[:birthday],
     country: params[:country], province: params[:province], distric: params[:distric],
     town: params[:town])
      flash[:success] = "Cập nhật thành công"
      redirect_to home_path
    else
      render :edit
    end
  end
end
