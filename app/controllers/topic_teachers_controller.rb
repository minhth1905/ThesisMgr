class TopicTeachersController < ApplicationController
  before_action :user_signin
  before_action :teacher
  skip_before_action :verify_authenticity_token
  def index
    @divisions = Topic.find_by_sql ['select topics.* from topics
      join divisions on topics.id = divisions.topic_id
      where divisions.teacher_id = ?', current_user.teacher.id]

    @students = []
    @divisions.each do |division|
      @student = Student.find_by(id: division.student_id)
      @name = @student.user.first_name + ' ' + @student.user.last_name
      @students << @name
    end
  end

  def new
  end

  def create
  end
end
