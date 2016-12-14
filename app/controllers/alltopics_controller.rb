class AlltopicsController < ApplicationController
  before_action :user_signin
  before_action :teacher, only: [:index]

  def index
    @topics = current_user.teacher.divisions
    @students = []
    @topics.each do |topic|
      @students << topic.topic.student.user.first_name + " " + topic.topic.student.user.last_name
    end
  end

  def show
    @id_teacher = params[:id]
    @teacher = Teacher.find_by(id: @id_teacher)
    @researches = @teacher.researches
  end
end
