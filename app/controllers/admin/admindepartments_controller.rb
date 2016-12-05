class Admin::AdmindepartmentsController < ApplicationController
  before_action :user_signin
  skip_before_action :verify_authenticity_token
  before_action :admin

  def index
    @users = User.where(rules: Settings.department_role)
  end

  def new
  end

  def create
    @password = rand(100000..999999)
    User.create(first_name: params[:first_name],last_name: params[:last_name],code: params[:macanbo],
      email: params[:email], rules: Settings.department_role, password: @password)
    @id = User.find_by(code: params[:macanbo])
    if @id
      flash[:success] = "Tạo tài khoản admin thành công"
      Departmentuser.create(job_title: params[:job_title], user_id: @id.id)
      User.find_by(id: @id.id).send_reset_password_instructions
    else
      flash[:danger] = "Tạo tài khoản thất bại"
    end
    redirect_to admin_admindepartments_path
  end

  def edit
    @user = User.find_by(id: params[:id])
    @admin = Departmentuser.find_by(user_id: @user.id)
  end

  def update
    @user = User.find_by(id: params[:id])
    @admin = Departmentuser.find_by(user_id: @user.id)
    if @user.update_attributes(first_name: params[:first_name],
     last_name: params[:last_name], birthday: params[:birthday],
     country: params[:country], province: params[:province], distric: params[:distric],
     town: params[:town]) && @admin.update_attributes(job_title: params[:job_title])
      flash[:success] = "Cập nhật thông tin thành công"
      redirect_to admin_admindepartments_path
    else
      flash[:danger] = "Cập nhật thông tin thất bại"
      render :edit
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @admin = Departmentuser.find_by(user_id: @user.id)
    if @admin.destroy && @user.destroy
      redirect_to admin_admindepartments_path
    else
      redirect_to admin_admindepartments_path
    end
  end
end
