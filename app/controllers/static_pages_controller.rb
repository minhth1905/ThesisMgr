class StaticPagesController < ApplicationController
  before_action :user_signin
  def index
    if params[:check] != "1" && current_user.rules == Settings.teacher_role
      if current_user.sign_in_count <= 1
        redirect_to edit_teacher_path(current_user.id, check: 1)
      end
    end
    if(current_user.rules == "4")
      @notification = Notification.where("department_id = ?", current_user.student.department_id).order("id DESC").limit(1)
      byebug
    elsif(current_user.rules == "3")
      @notification = Notification.where("department_id = ?", current_user.teacher.department_id).order("id DESC").limit(1)
    end

  end

  def home

  end
end
