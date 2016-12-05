class Admin::DepartmentsController < ApplicationController
  before_action :user_signin
  before_action :admin_department, only: [:edit, :update, :destroy, :new]
  before_action :find_department, only: [:show, :edit, :update, :destroy]
  def index
    @departments = Department.all
  end

  def show
  end

  def tree
    @departments = Department.paginate(page: params[:page],:per_page => 1)
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.new(department_params)
    if @department.save
      flash[:success] = "Thêm khoa thành công"
      redirect_to admin_departments_path
    else
      flash[:danger] = "Thêm khoa thất bại"
      render :new
    end
  end

  def edit
  end

  def update
    if @department.update_attributes(department_params)
      flash[:success] = "Cập nhật khoa thành công"
      redirect_to admin_departments_path
    else
      flash[:danger] = "Cập nhật khoa thất bại"
      render :edit
    end
  end

  def destroy
    if @department.destroy
      flash[:success] = "Xóa khoa thành công"
      redirect_to admin_departments_path
    else
      flash[:danger] = "Xóa khoa thất bại"
      redirect_to admin_departments_path
    end
  end

  private
  def department_params
    params.require(:department).permit(:name, :office)
  end

  def find_department
    @department = Department.find_by(id: params[:id])
  end
end
