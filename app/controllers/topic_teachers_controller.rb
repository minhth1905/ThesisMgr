class TopicTeachersController < ApplicationController
  before_action :user_signin
  before_action :teacher
  skip_before_action :verify_authenticity_token
  def index
    @topics = Topic.find_by_sql ['select topics.* from topics
      join divisions on topics.id = divisions.topic_id
      where divisions.teacher_id = ?', current_user.teacher.id]

    @students = []
    @topics.each do |topic|
      @student = Student.find_by(id: topic.student_id)
      @name = @student.user.first_name + ' ' + @student.user.last_name
      @students << @name
    end

    if(params[:accept] && params[:accept] === 'true')
      @topic = Topic.find_by(id: params[:topic_id])
      if @topic.update_attributes(status: 1)
        flash[:success] = "Cập nhật thành công"
      end
      @arr = "thanh cong"
      respond_to do |format|
        format.html
        format.text {render json: @arr}
      end
    end

    if(params[:deny] && params[:deny] === 'true')
      @topic = Topic.find_by(id: params[:topic_id])
      if @topic.update_attributes(status: 2)
        flash[:success] = "Cập nhật thành công"
      end
      @arr = "thanh cong"
      respond_to do |format|
        format.html
        format.text {render json: @arr}
      end
    end

  end

  def new
  end

  def create
  end
end
