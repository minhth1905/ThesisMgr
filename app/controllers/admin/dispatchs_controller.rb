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
  def protect
    @topics_protect = Topic.where(is_proteced: 3)
    respond_to do |format|
      format.docx { headers["Content-Disposition"] = "attachment; filename=\"congvanbaove.docx\"" }
    end
  end
  def protect_excel
    @topics_protect = Topic.where(is_proteced: 3)
    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="danhsachbaove.xlsx"'
      }
    end
  end
end
