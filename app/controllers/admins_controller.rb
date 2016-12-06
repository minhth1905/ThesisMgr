class AdminsController < ApplicationController
  def show
  end

  def edit
    @user = User.find_by(id: params[:id])
  end
  def update
    @user = User.find_by(id: params[:id])
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
