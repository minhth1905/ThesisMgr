class Admin::TeachersController < ApplicationController
  before_action :user_signin
  before_action :admin_department, only: [:new, :destroy]
  skip_before_action :verify_authenticity_token
  def index
    @users = User.where(rules: Settings.teacher_role)
    @subjects = Subject.where(department_id: current_user.departmentuser.department_id)
  end

  def show
  end

  def edit
    @user = User.find_by(id: params[:id])
    @teacher = Teacher.find_by(user_id: @user.id)
    @subject = Subject.find_by(id: @teacher.subject_id)
    @subjects = Subject.all
  end

  def update
    @user = User.find_by(id: params[:id])
    @teacher = Teacher.find_by(user_id: @user.id)
    if @user.update_attributes(first_name: params[:first_name],
     last_name: params[:last_name], code: params[:macanbo]) && @teacher.update_attributes(subject_id: params[:subject_id])
      flash[:success] = "Cập nhật thông tin thành công"
      redirect_to admin_students_path
    else
      flash[:danger] = "Cập nhật thông tin thất bại"
      render :edit
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @teacher = Teacher.find_by(user_id: @user.id)
    if @teacher.destroy && @user.destroy
      flash[:success] = "Xóa tài khoản thành công"
      redirect_to admin_teachers_path
    else
      flash[:danger] = "Xóa tài khoản thất bại"
      redirect_to admin_teachers_path
    end
  end

  def new
    @subjects = Subject.where(department_id: current_user.departmentuser.department_id)
  end

  def create
    total_id = []
    @user_id = User.new_teacher(params[:first_name], params[:last_name], params[:macanbo],
      params[:email], params[:description], params[:subject], current_user.departmentuser.department_id)
    total_id << @user_id
    User.delay.send_email_teacher(total_id)
    # User.find_by(id: @user_id).send_reset_password_instructions
    flash[:success] = "Thêm giáo viên thành công, hệ thống đang gửi email"
    redirect_to admin_teachers_path
  end


  def import
    total_id = User.import(params[:file], current_user.departmentuser.department_id)
    # total_id.each do |id|
    #   User.find_by(id: id).send_reset_password_instructions
    # end
    User.delay.send_email_teacher(total_id)
    redirect_to admin_teachers_path, notice: "Thêm thành công dữ liệu giảng viên, hệ thống đang gửi email"
  end

  private
  def teacher_params
    params.require(:course).permit(:name)
  end
end
