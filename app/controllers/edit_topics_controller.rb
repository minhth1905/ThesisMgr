class EditTopicsController < ApplicationController
  before_action :user_signin
  before_action :student
  skip_before_action :verify_authenticity_token

  def index
    @topic = Topic.where(student_id: current_user.student.id)
    if @topic.blank?
      @check = 0
    elsif @topic[0].status == 1
      @check = 1
    else
      @check = 0
    end

  end

  def create
    if params[:destroy]
      @topic = Topic.find_by(student_id: current_user.student.id)
      @topic.update_attributes(status: 6)
      flash[:success] = "Đã đề nghị hủy đề tài"
      redirect_to root_url, notice: "Đã đề nghị hủy đề tài"
    else
      redirect_to root_url
      flash[:danger] = "Thất bại"
    end
  end
end
