class Admin::BooksController < ApplicationController
  before_action :user_signin
  before_action :department
  skip_before_action :verify_authenticity_token

  def index
    @timenotifi = Timenotifi.find_by(department_id: current_user.departmentuser.department_id)
    if @timenotifi.blank?
      @check = 0
    elsif @timenotifi.status < 2
      @check = 1
    else
      @check = 0
    end
    @subject = "Email nhắc nhở về việc hoàn thành hồ sơ khóa luận"
    @content = "Nhà trường nhắc nhở sinh viên về việc hoàn thành hồ sơ khóa luận. Đề nghị sinh viên hoàn tất hồ sơ nộp cho khoa bộ môn"

    @topics = Topic.where(is_proteced: 3)

    if(params[:topic_id])
      @topic = Topic.find_by(id: params[:topic_id])
      if @topic.update_attributes(is_proteced: 4)
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
      @topics = Topic.where(is_proteced: 3)
      @students = []
      @topics.each do |topic|
        @students << topic.student.user
      end
      if @students.length
        User.delay.send_email(@students, params[:subject], params[:content])
        redirect_to admin_books_path, notice: "Đang gửi email thông báo cho #{@students.length} sinh viên"
      else
        flash[:danger] = "Không có sinh viên nào trong trạng thái được thông báo"
        render :new
      end
    end
  end
end
