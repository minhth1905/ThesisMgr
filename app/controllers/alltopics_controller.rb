class AlltopicsController < ApplicationController
  before_action :user_signin
  before_action :teacher

  def index
    @topics = current_user.teacher.divisions
    @students = []
    @topics.each do |topic|
      @students << topic.topic.student.user.first_name + " " + topic.topic.student.user.last_name
    end
  end
end
