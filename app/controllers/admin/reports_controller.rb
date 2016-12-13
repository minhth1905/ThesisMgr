class Admin::ReportsController < ApplicationController
  before_action :user_signin
  before_action :department
  skip_before_action :verify_authenticity_token

  def index
    @topic = Topic.where(is_proteced: 3)
    @topics = []
    @topic.each do |t|
      if t.report.nil?
        @topics << t
      end
    end
  end
  def onereport
    @report = Report.find_by(id: params[:id])
    respond_to do |format|
      format.docx { headers["Content-Disposition"] = "attachment; filename=\"bienbanbaove.docx\"" }
    end
  end
  def edit
    @topic = Topic.find_by(id: params[:id])
  end

  def update
    @topic = Topic.find_by(id: params[:id])
    Report.create(count: params[:count], opinion_teacher: params[:opinion_teacher],
      opinion_depart: params[:opinion_depart], topic_id: params[:id])
    flash[:success] = "Nhập ý kiến thành công"
    redirect_to admin_reports_path
  end
  def report
    @reports = Report.all
  end
end
