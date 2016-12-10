class Admin::CouncilsController < ApplicationController
  before_action :user_signin
  before_action :department
  skip_before_action :verify_authenticity_token

  def index
    @name = current_user.departmentuser.department.name
    @council = Council.find_by(department_id: current_user.departmentuser.department_id)
    @departments = Department.all
    @subjects = Subject.all
    @teacher = Teacher.all
    if(params[:department_id])
      department_id = params[:department_id]
      @department = Department.find_by(id: department_id)
      @subjects_belong_department = @department.subjects
      # do something with some_parameter and return the results

      respond_to do |format|
        format.html
        format.text {render json: @subjects_belong_department}
      end
    end

    if(params[:subject_id])
      subject_id = params[:subject_id]
      @subject = Subject.find_by(id: subject_id)
      @teachers_belong_subject = Teacher.joins(:user)
       .select('teachers.*,users.first_name,users.last_name')
       .where("teachers.subject_id = ?", subject_id)
      # byebug
      # do something with some_parameter and return the results

      respond_to do |format|
        format.html
        format.text {render json: @teachers_belong_subject}
      end
    end
  end

  def create
    @council = Council.find_by(department_id: current_user.departmentuser.department_id)
    if params[:check]
      if @council.blank?
        Council.create(name: params[:name_topic], chairman: params[:teacher_id],
          commissioner: params[:teacher_id_3], secretary: params[:teacher_id_2],
          department_id: current_user.departmentuser.department_id)
        redirect_to admin_councils_path, notice: "Tạo hội đồng thành công"
      else
        Council.update_attributes(name: params[:name_topic],
          chairman: params[:teacher_id], commissioner: params[:teacher_id_3],
          secretary: params[:teacher_id_2])
        redirect_to admin_councils_path, notice: "Thay đổi hội đồng thành công"
      end
    end
  end
end
