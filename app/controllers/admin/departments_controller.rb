class Admin::DepartmentsController < ApplicationController
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
      redirect_to admin_departments_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @department.update_attributes(department_params)
      redirect_to admin_departments_path
    else
      render :edit
    end
  end

  def destroy
    if @department.destroy
      redirect_to admin_departments_path
    else
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
