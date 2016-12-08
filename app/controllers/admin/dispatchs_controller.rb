class Admin::DispatchsController < ApplicationController
  def show
    @students = Student.where(status: 1)
    respond_to do |format|
      format.docx { headers["Content-Disposition"] = "attachment; filename=\"congvan.docx\"" }
    end
  end

  def index
    @students = Student.where(status: 1)
  end

  def cancel
    @topics = Topic.where(status: 5)
    respond_to do |format|
      format.docx { headers["Content-Disposition"] = "attachment; filename=\"congvanxinthoi.docx\"" }
    end
  end

end
