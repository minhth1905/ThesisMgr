class Admin::DepartmentusersController < ApplicationController
  def index
    @users = User.all
  end
  def import
    Departmentuser.import(params[:file])
    redirect_to admin_departmentusers_path, notice: "Products imported."
  end
end
