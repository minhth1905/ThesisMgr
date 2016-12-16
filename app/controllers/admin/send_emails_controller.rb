class Admin::SendEmailsController < ApplicationController
  before_action :user_signin
  before_action :department
  skip_before_action :verify_authenticity_token

  def new
    @subject = "Email thông báo việc mở cổng đăng ký đề tài"
    @content = "Nhà trường thông báo đến toàn thể sinh viên về việc mở cổng đăng ký đề
    tài khóa luận tốt nghiệp của sinh viên. Đề nghị sinh viên truy cập trang web đề tham gia đăng ký"
    @subject_danger = "Email nhắc nhở việc mở cổng đăng ký đề tài"
    @content_danger = "Nhà trường nhắc nhở đến toàn thể sinh viên về việc mở cổng đăng ký đề
    tài khóa luận tốt nghiệp của sinh viên. Đề nghị sinh viên khẩn trương truy cập trang web đề tham gia đăng ký"
  end

  def create
    if params[:notifi]
      @users = User.where(rules: Settings.student_role)
      @students = []
      @users.each do |user|
        if user.student.status == 1
          @students << user
        end
      end
      if @students.length
        User.delay.send_email(@students, params[:subject], params[:content])
        flash[:success] = "Đã gửi email cho #{@students.length} sinh viên"
        redirect_to home_path, notice: "Đang gửi email thông báo cho #{@students.length} sinh viên"
      else
        flash[:danger] = "Không có sinh viên nào trong trạng thái được đăng ký"
        render :new
      end
    else
      @users = User.where(rules: Settings.student_role)
      @students = []
      @users.each do |user|
        if user.student.status.nil?
          @students << user
        end
      end
      if @students.length
        User.delay.send_email(@students, params[:subject], params[:content])
         flash[:success] = "Đang gửi email cho #{@students.length} sinh viên"
        redirect_to home_path, notice: "Đang gửi email nhắc nhở cho #{@students.length} sinh viên"
      else
        flash[:danger] = "Không có sinh viên nào trong trạng thái được đăng ký"
        render :new
      end
    end
  end
end
