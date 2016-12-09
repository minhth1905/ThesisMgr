class EditTopicsController < ApplicationController
  before_action :user_signin
  before_action :student
  skip_before_action :verify_authenticity_token

  def index
    @timenotifi = Timenotifi.find_by(department_id: current_user.student.department_id)
    @topic = Topic.where(student_id: current_user.student.id)
    # ì @topic.blank?
    #   @check = 0
    # elsif @timenotifi.blank?
    #   @check = -1
    # elsif @timenotifi.status

    # elsif @topic[0ư.status == 1
    #   @check = 1
    # else
    #   @check = 0
    # end
    if @timenotifi.blank?
      @check = -1
    elsif @timenotifi.status == 2
      if @topic[0].status == 1
        @check = 1
      elsif @topic[0].status == 3
        @check = 2 #dang doi sua
      elsif @topic[0].status == 4
        @check = 3 #sua thanh cong
      elsif @topic[0].status  == 5
        @check = 4 #rut thanh cong
      elsif @topic[0].status == 6
        @check = 5 #dang cho rut
      elsif @topic[0].status == 7
        @check = 6 #sua khong thanh cong
      elsif @topic[0].status == 8
        @check = 7 #rut khong thanh  cong
      end
    else
      @check = 0
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
    if params[:destroy]
      @topic = Topic.find_by(student_id: current_user.student.id)
      @topic.update_attributes(status: 6)
      flash[:success] = "Đã đề nghị hủy đề tài"
      redirect_to root_url, notice: "Đã đề nghị hủy đề tài"
    elsif params[:edit]
      @topic = Topic.find_by(student_id: current_user.student.id)
      @topic.update_attributes(new_name: params[:name_topic], description: params[:description], status: 3)
      @divisions = @topic.divisions
      @divisions.each do |division|
        division.destroy
      end
      Division.create(teacher_id: params[:teacher_id], topic_id: @topic.id)
      if params[:teacher_id_2]
        Division.create(teacher_id: params[:teacher_id_2], topic_id: @topic.id)
      end
      flash[:success] = "Đã yêu cầu sửa thành công"
      redirect_to edit_topics_path
    end
  end

  def update
  end
end
