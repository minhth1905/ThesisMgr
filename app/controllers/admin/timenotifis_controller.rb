class Admin::TimenotifisController < ApplicationController
  before_action :user_signin
  before_action :department
  skip_before_action :verify_authenticity_token

  def index
    @notifi = Timenotifi.find_by(department_id: current_user.departmentuser.department_id)
    if @notifi.blank?
      @noti = "Hệ thống chưa được mở đăng ký"
      @check = 0 # He thong chua mo dang ky
    elsif @notifi.status == 0
      @noti = "Hệ thống chưa được mở đăng ký"
      @check = 0 # He thong chua mo dang ky
    elsif @notifi.status == 2
      @noti = "Hệ thống đăng ký đã được đóng"
      @check = 0 #He thong da dong dang ky
      @time_end = @notifi.time_end
    else
      @noti = "Hệ thống đăng ký đang được mở"
      @check = 1 #He thong dang mo dang ky
    end
  end

  def show
  end

  def new
    @notifi = Timenotifi.find_by(department_id: current_user.departmentuser.department_id)
    if @notifi.blank?
      @check = 0 # He thong chua mo dang ky
    elsif @notifi.status == 0
      @check = 0 #He thong da dong dang ky
      @time_end = @notifi.time_end
    else
      @check = 1 #He thong dang mo dang ky
    end
  end

  def create
    @notifi = Timenotifi.find_by(department_id: current_user.departmentuser.department_id)
    if params[:check].to_i == 0
      @time_start = Time.now
      @time_end = params[:time].to_datetime
      @elapsed_minus = ((@time_end - @time_start.to_datetime)*24*60*60).to_i - 7*60*60
      @minus = @elapsed_minus/60
      if @notifi.blank?
        @value = Timenotifi.new(time_start: @time_start, time_end: params[:time].to_datetime,
          department_id: current_user.departmentuser.department_id, status: 1)
        @value.save
        @id = @value.id
        Timenotifi.delay(run_at: @minus.minutes.from_now).auto_close(@id, current_user)
      else
        @notifi.update_attributes(status: 1)
        Timenotifi.delay(run_at: @minus.minutes.from_now).auto_close(@notifi.id, current_user)
      end
      redirect_to admin_timenotifis_path, notice: "Hệ thống đã mở và sẽ tự động đóng"

      Notification.where("department_id = ?", current_user.departmentuser.department.id).destroy_all
      Notification.create(content: "đang mở hệ thống đăng kí", status: "1", department_id: current_user.departmentuser.department_id)
      Pusher.trigger('notifications-of-department-' + current_user.departmentuser.department_id.to_s, 'new_notification', {
          message: current_user.departmentuser.department.name.to_s + " đang mở hệ thống đăng kí."
          # current_user.departmentuser.department_id.to_s
      })

    else
      @notifi.update_attributes(status: 2)
      redirect_to admin_timenotifis_path
      Notification.where("department_id = ?", current_user.departmentuser.department.id).destroy_all
      Notification.create(content: "đã đóng hệ thống đăng kí", status: "1", department_id: current_user.departmentuser.department_id)
      Pusher.trigger('notifications-of-department-' + current_user.departmentuser.department_id.to_s, 'new_notification', {
          message: current_user.departmentuser.department.name.to_s + " đã đóng hệ thống đăng kí."
      })
    end
  end

  def edit
  end

  def update
  end
end
