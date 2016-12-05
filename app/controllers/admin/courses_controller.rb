class Admin::CoursesController < ApplicationController
  before_action :user_signin
  before_action :find_course, only: [:show, :edit, :update, :destroy]
  before_action :admin_department, only: [:edit, :update, :destroy, :new]
  def index
    @courses = Course.all
  end

  def show
    @course = Course.find_by(id: params[:id])
  end

  def tree
    @trainings = Training.all
    @courses_index = Course.all
    @courses = Course.paginate(page: params[:page],:per_page => 1)
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      flash[:success] = "Tạo khóa học thành công"
      redirect_to admin_courses_path
    else
      flash[:danger] = "Tạo khóa học thất bại"
      render :new
    end
  end

  def edit
  end

  def update
    if @course.update_attributes(course_params)
      flash[:success] = "Cập nhật khóa học thành công"
      redirect_to admin_courses_path
    else
      flash[:danger] = "Cập nhật khóa học thất bại"
      render :edit
    end
  end

  def destroy
    if @course.destroy
      redirect_to admin_courses_path
      flash[:success] = "Xóa khóa học thành công"
    else
      flash[:danger] = "Xóa khóa học thất bại"
      redirect_to admin_courses_path
    end
  end

  private
  def course_params
    params.require(:course).permit(:name)
  end
  def find_course
    @course = Course.find_by(id: params[:id])
  end
end
