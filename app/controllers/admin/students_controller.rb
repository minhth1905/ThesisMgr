class Admin::StudentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :admin_department, only: [:new, :destroy, :import]
  def index
    @users = User.where(rules: Settings.student_role)
    @courses = Course.all
    @trainings = Training.all
  end

  def show
  end

  def new
    @student = Student.new
    @courses = Course.all
    @trainings = Training.all
    if(params[:course_id])
      course_id = params[:course_id]
      @course = Course.find_by(id: course_id)
      @training_belong_course = @course.trainings
      # do something with some_parameter and return the results

      respond_to do |format|
        format.html
        format.text {render json: @training_belong_course}
      end
    end
  end

  def create
    @password = rand(100000..999999)
    User.create(first_name: params[:first_name],last_name: params[:last_name],code: params[:macanbo],
      email: params[:email], rules: Settings.student_role, password: @password)
    @id = User.find_by(code: params[:macanbo])
    if @id
      flash[:success] = "Tạo tài khoản thành công"
      Student.create(status: params[:status], user_id: @id.id, department_id: current_user.departmentuser.department_id,
        course_id: params[:course_id], training_id: params[:training_id])
      User.find_by(id: @id.id).send_reset_password_instructions
    else
      flash[:danger] = "Tạo tài khoản thất bại"
    end
    redirect_to admin_students_path
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def import
    total_id = User.import_student(params[:file], current_user.departmentuser.department_id)
    total_id.each do |id|
      User.find_by(id: id).send_reset_password_instructions
    end
    @number = total_id.length
    redirect_to admin_students_path, notice: "Đã tạo thành công #{@number} tài khoản"
  end

end
