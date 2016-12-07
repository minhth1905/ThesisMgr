class TopicsController < ApplicationController
  before_action :user_signin
  before_action :student
  skip_before_action :verify_authenticity_token

  def index
    @timenotifi = Timenotifi.where(department_id: current_user.student.department_id)
    @topic_of_student = current_user.student.topic
    if @timenotifi.blank?
      @check = -1
    elsif @timenotifi[0].status == 0
      @check = 0
    elsif @topic_of_student.blank?
      @check = 1 #dang ky de tai
    else
      @check = 2 #sua de tai
    end

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
    render text:params
  end
end
