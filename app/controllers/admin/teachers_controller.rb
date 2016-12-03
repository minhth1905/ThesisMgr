class Admin::TeachersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @users = User.all
    @departments = Department.all
    @subjects = Subject.all
    # byebug
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
    User.new_teacher(params[:first_name], params[:last_name], params[:macanbo],params[:email], params[:description])
    redirect_to admin_teachers_path
  end


  def import
    User.import(params[:file])
    redirect_to admin_teachers_path, notice: "Products imported."
  end

  private
  def teacher_params
    params.require(:course).permit(:name)
  end
end
