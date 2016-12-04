class Admin::StudentsController < ApplicationController
  before_action :admin_department, only: [:new, :destroy, :import]
  def index
  end

  def show
  end

  def new
  end

  def create
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
    redirect_to admin_students_path, notice: "Products imported."
  end

end
