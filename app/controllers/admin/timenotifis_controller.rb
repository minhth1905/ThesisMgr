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
      if @notifi.blank?
        Timenotifi.create(time_start: @time_start, time_end: params[:time].to_datetime,
          department_id: current_user.departmentuser.department_id, status: 1)
      else
        @notifi.update_attributes(status: 1)
      end
      redirect_to admin_timenotifis_path
    else
      @notifi.update_attributes(status: 0)
      redirect_to admin_timenotifis_path
    end
  end

  def edit
  end

  def update
  end
end
