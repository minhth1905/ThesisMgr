class Admin::TimeProtectsController < ApplicationController
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
    @subject = "Email thông báo về thời gian bảo vệ khóa luận"
    @content = "Nhà trường thông báo đến toàn thể sinh viên về việc bảo vệ đề
    tài khóa luận tốt nghiệp của sinh viên. Đề nghị sinh viên hoàn tất hồ sơ nộp cho khoa bộ môn"
  end

  def create
    if params[:notifi]
      @topics = Topic.where(status: 1, is_proteced: nil)
      @students = []
      @timenotifi = Timenotifi.find_by(department_id: current_user.departmentuser.department_id)
      @timenotifi.update_attributes(status: 0)
      @topics.each do |topic|
        topic.update_attributes(is_proteced: 1)
        @students << topic.student.user
      end
      if @students.length
        User.delay.send_email(@students, params[:subject], params[:content])
        redirect_to home_path, notice: "Đang gửi email thông báo cho #{@students.length} sinh viên"
      else
        flash[:danger] = "Không có sinh viên nào trong trạng thái được bảo vệ"
        render :new
      end
    end
  end
end
