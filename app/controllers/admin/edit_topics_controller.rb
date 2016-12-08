class Admin::EditTopicsController < ApplicationController
  before_action :user_signin
  before_action :department
  skip_before_action :verify_authenticity_token
  def index
    @topics = Topic.where(status: 3)

    @students = []
    @codes = []
    @topics.each do |topic|
      @student = Student.find_by(id: topic.student_id)
      @name = @student.user.first_name + ' ' + @student.user.last_name
      @code = @student.user.code
      @students << @name
      @codes << @code
    end
  end

  def new
  end

  def create
  end
end
