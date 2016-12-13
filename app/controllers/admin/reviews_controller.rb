class Admin::ReviewsController < ApplicationController
  before_action :user_signin
  before_action :department
  skip_before_action :verify_authenticity_token

  def index
    @topic = Topic.where(is_proteced: 3)
    @topics = []
    @topic.each do |t|
      if t.reviews.blank?
        @topics << t
      end
    end
  end

  def edit
    @topic = Topic.find_by(id: params[:id])
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

  def update
    @topic = Topic.find_by(id: params[:id])
    @review = @topic.reviews
    if @review.blank?
      if params[:teacher_id]
        Review.create(topic_id: params[:id], teacher_id: params[:teacher_id])
      end
      if params[:teacher_id_2]
        Review.create(topic_id: params[:id], teacher_id: params[:teacher_id_2])
      end
    redirect_to admin_reviews_path, notice: "Phân công phản biện cho đề tài thành công"
    else
      redirect_to edit_admin_review_path, notice: "Phân công phản biện cho đề tài thất bại"
    end

  end

  def example
    @topics_protect = Topic.where(is_proteced: 3)
    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="filemau.xlsx"'
      }
    end
  end
end
