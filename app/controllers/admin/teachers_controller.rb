class Admin::TeachersController < ApplicationController
  def index
    @users = User.all
  end
  def import
    User.import(params[:file])
    Teacher.import(params[:file])
    redirect_to admin_teachers_path, notice: "Products imported."
  end
end
