class Admin::DispatchsController < ApplicationController
  def show
    @students = Student.where(status: 1)
    respond_to do |format|
      format.docx { headers["Content-Disposition"] = "attachment; filename=\"congvan.docx\"" }
    end
  end

  def index
    @students = Student.where(status: 1)
    @topics_cancel = Topic.where(status: 5)
    @topics_edit = Topic.where(status: 4)
  end

  def cancel
    @topics_cancel = Topic.where(status: 5)
    respond_to do |format|
      format.docx { headers["Content-Disposition"] = "attachment; filename=\"congvanxinthoi.docx\"" }
    end
  end
  def edit
    @topics_edit = Topic.where(status: 4)
    respond_to do |format|
      format.docx { headers["Content-Disposition"] = "attachment; filename=\"congvansuadoi.docx\"" }
    end
  end
end
