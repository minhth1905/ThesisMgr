class Admin::AdminsController < ApplicationController
  before_action :user_signin
  skip_before_action :verify_authenticity_token
  before_action :admin

  def index
    @users = User.where(rules: 1)
  end

  def new
  end

  def create
    @password = rand(100000..999999)
    User.create(first_name: params[:first_name],last_name: params[:last_name],code: params[:macanbo],
      email: params[:email], rules: 1, password: @password)
    @id = User.find_by(code: params[:macanbo])
    if @id
      flash[:success] = "Tạo tài khoản admin thành công"
      Admin.create(job_title: params[:job_title], user_id: @id.id)
      User.find_by(id: @id.id).send_reset_password_instructions
    else
      flash[:danger] = "Tạo tài khoản thất bại"
    end
    redirect_to admin_admins_path
  end

  def edit
    @user = User.find_by(id: params[:id])
    @admin = Admin.find_by(user_id: @user.id)
  end

  def update
    @user = User.find_by(id: params[:id])
    @admin = Admin.find_by(user_id: @user.id)
    if @user.update_attributes(first_name: params[:first_name],
     last_name: params[:last_name], birthday: params[:birthday],
     country: params[:country], province: params[:province], distric: params[:distric],
     town: params[:town]) && @admin.update_attributes(job_title: params[:job_title])
      flash[:success] = "Cập nhâth thông tin thành công"
      redirect_to admin_admins_path
    else
      flash[:danger] = "Cập nhật thông tin thất bại"
      render :edit
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @admin = Admin.find_by(user_id: @user.id)
    if @admin.destroy && @user.destroy
      flash[:success] = "Xóa tài khoản thành công"
      redirect_to admin_admins_path
    else
      flash[:danger] = "Xóa tài khoản thất bại"
      redirect_to admin_admins_path
    end
  end

end
