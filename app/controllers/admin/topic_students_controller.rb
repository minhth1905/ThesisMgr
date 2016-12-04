class Admin::TopicStudentsController < ApplicationController
  before_action :department
  skip_before_action :verify_authenticity_token

  def index
    @users = User.where(rules: Settings.student_role)
    @students = []
    @users.each do |user|
      if user.student.status == 1
        @students << user
      end
    end
  end

  def import
    @totals = User.import_update(params[:file])
    @total = @totals.length
    redirect_to admin_topic_students_path, notice: "Đã update #{@total} sinh viên."
  end

  def new
  end

  def create
    @user = User.find_by(code: params[:macanbo])
    if @user
      @student = @user.student
      if @student
        if @student.update_attributes(status: 1)
          flash[:success] = "Cập nhật thành công"
          redirect_to admin_topic_students_path
        else
          flash[:danger] = "Cập nhật không thành công"
        end
      else
        flash[:danger] = "Không có sinh viên trong dữ liệu"
        render :new
      end
    else
      flash[:danger] = "Không có sinh viên trong dữ liệu"
      redirect_to admin_topic_students_path
    end
  end

end
