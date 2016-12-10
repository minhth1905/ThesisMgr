class Admin::FilesController < ApplicationController
  before_action :user_signin
  before_action :department
  skip_before_action :verify_authenticity_token

  def index
    @timenotifi = Timenotifi.find_by(department_id: current_user.departmentuser.department_id)
    if @timenotifi.blank?
      @check = 0
    end
    @subject = "Email nhắc nhở về việc nộp hồ sơ khóa luận"
    @content = "Nhà trường thông báo đến sinh viên để nhắc nhở về việc nộp hồ sơ đề
    tài khóa luận tốt nghiệp của sinh viên. Đề nghị sinh viên hoàn tất hồ sơ nộp cho khoa bộ môn"

    @topic = Topic.where(status: 1, is_proteced: 1)
    @topics = Topic.where(status: 1, is_proteced: 2)

    if(params[:topic_id])
      @topic_confirm = Topic.find_by(id: params[:topic_id])
      if @topic_confirm.update_attributes(is_proteced: 3)
        flash[:success] = "Cập nhật thành công"
      end
      @arr = "thanh cong"
      respond_to do |format|
        format.html
        format.text {render json: @arr}
      end
    end
  end

  def create
    if params[:notifi]
      @topics = Topic.where(status: 1, is_proteced: 1)
      @students = []
      @topics.each do |topic|
        @students << topic.student.user
      end
      if @students.length
        User.delay.send_email(@students, params[:subject], params[:content])
        redirect_to admin_files_path, notice: "Đang gửi email thông báo cho #{@students.length} sinh viên"
      else
        flash[:danger] = "Không có sinh viên nào trong trạng thái được bảo vệ"
        render :new
      end
    end
  end
end
