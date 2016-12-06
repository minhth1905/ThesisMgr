class TeachersController < ApplicationController
  before_action :user_signin
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
      redirect_to home_path(check: 1)
    else
      render :edit
    end
  end

  #chua phan quyen
  def index
    @teachers = Teacher.joins(:user,:department,:subject)
       .select('teachers.*,users.first_name,users.last_name,departments.id as department_id,departments.name as department_name,subjects.id as subject_id,subjects.name as subject_name')
       .where("subjects.department_id = departments.id")
       .paginate(:page => params[:page], :per_page => 1)


    @teachers.each do |item|
      @researches = Research.joins(:teacher).where("researches.teacher_id = ?",item.id)
      item.researches << @researches
    end

    @departments = Department.all
    if(params[:department_id])
      @arr = {}
      department_id = params[:department_id]
      @department = Department.find_by(id: department_id)

      @subject_belong_department = @department.subjects
      @arr.store("subjects",@subject_belong_department)
      # do something with some_parameter and return the results
      # @teacher_belong_department = @department.teachers
      # @arr.store("teachers",@teacher_belong_department)



      respond_to do |format|
        format.html
        format.text {render json: @arr}
      end
    end

    @spheres = Sphere.all
    @list_tree_spheres = show_tree(@spheres,0,0)
    if(params[:sphere_id])
      @arr = {}
      sphere_id = params[:sphere_id]

      @research_belong_sphere = Research.find_by_sql ["select r.* from researches r join searchspheres s on r.id = s.research_id where s.sphere_id = ?",sphere_id]
      @arr.store("researches",@research_belong_sphere)

      respond_to do |format|
        format.html
        format.text {render json: @arr}
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @teachers }
      format.js
    end
  end
end
