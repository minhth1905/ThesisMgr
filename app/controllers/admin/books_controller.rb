class Admin::BooksController < ApplicationController
  before_action :user_signin
  before_action :department
  skip_before_action :verify_authenticity_token

  def index
    @timenotifi = Timenotifi.find_by(department_id: current_user.departmentuser.department_id)
    if @timenotifi.blank?
      @check = 0
    elsif @timenotifi.status < 2
      @check = 0
    else
      @check = 1
    end
    @subject = "Email nhắc nhở về việc hoàn thành hồ sơ khóa luận"
    @content = "Nhà trường nhắc nhở sinh viên về việc hoàn thành hồ sơ khóa luận. Đề nghị sinh viên hoàn tất hồ sơ nộp cho khoa bộ môn"

    @topics = Topic.where(status: 1, is_proteced: 3)
  end
end
