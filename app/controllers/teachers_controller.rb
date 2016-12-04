class TeachersController < ApplicationController
  def show
  end
  def edit
    @user = User.find_by(id: params[:id])
    @teacher = Teacher.find_by(user_id: @user.id)
  end
  def update
    @user = User.find_by(id: params[:id])
    @teacher = Teacher.find_by(user_id: @user.id)
    if @user.update_attributes(first_name: params[:first_name],
     last_name: params[:last_name], birthday: params[:birthday],
     country: params[:country], province: params[:province], distric: params[:distric],
     town: params[:town]) && @teacher.update_attributes(description: params[:description])
      flash[:success] = "Cập nhật thành công"
      redirect_to home_path
    else
      render :edit

  #chua phan quyen
  def index
    @teachers = Teacher.joins(:user,:department,:subject)
       .select('teachers.*,users.first_name,users.last_name,departments.name as department_name,subjects.name as subject_name').where("subjects.department_id = departments.id")
    @teachers.each do |item|
      @researches = Research.joins(:teacher).where("researches.teacher_id = ?",item.id)
      item.researches = @researches
    end
    @departments = Department.all
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
end
