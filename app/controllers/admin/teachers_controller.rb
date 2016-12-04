class Admin::TeachersController < ApplicationController
  before_action :admin_department, only: [:new, :destroy]
  skip_before_action :verify_authenticity_token
  def index
    @users = User.where(rules: Settings.teacher_role)
    @departments = Department.all
    @subjects = Subject.all
  end

  def show
  end

  def edit
  end

  def new
    @teacher = Teacher.new
    @departments = Department.all
    @subjects = Subject.all
    if(params[:department_id])
      department_id = params[:department_id]
      @department = Department.find_by(id: department_id)
      @subject_belong_department = @department.subjects
      # do something with some_parameter and return the results

      respond_to do |format|
        format.html
        format.text {render json: @subject_belong_department}
      end
    end
  end

  def create
    @user_id = User.new_teacher(params[:first_name], params[:last_name], params[:macanbo],
      params[:email], params[:description], params[:subject], current_user.departmentuser.department_id)
    User.find_by(id: @user_id).send_reset_password_instructions
    flash[:success] = "Thêm giáo viên thành công"
    redirect_to admin_teachers_path
  end


  def import
    total_id = User.import(params[:file], current_user.departmentuser.department_id)
    total_id.each do |id|
      User.find_by(id: id).send_reset_password_instructions
    end
    redirect_to admin_teachers_path, notice: "Products imported."
  end

  private
  def teacher_params
    params.require(:course).permit(:name)
  end
end
