class Admin::DispatchsController < ApplicationController
  def show
    @students = Student.where(status: 1)
    respond_to do |format|
      format.docx { headers["Content-Disposition"] = "attachment; filename=\"congvandetai.docx\"" }
    end
  end

  def index
    @timenotifi = Timenotifi.find_by(department_id: current_user.departmentuser.department_id)
    @students = Student.where(status: 1)
    @topics_cancel = Topic.where(status: 5)
    @topics_edit = Topic.where(status: 4)
    if @timenotifi.blank?
      @check = 0
    elsif @timenotifi.status != 2
      @check = 0
    else
      @check = 1
    end
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
  def protect_word
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
  def protect
    @topics_protect = Topic.where(is_proteced: 3)
  end
  def councils
    @council = Council.find_by(department_id: current_user.departmentuser.id)
    respond_to do |format|
      format.docx { headers["Content-Disposition"] = "attachment; filename=\"congvanhoidong.docx\"" }
    end
  end
  def indexcouncil
    @council = Council.find_by(department_id: current_user.departmentuser.id)
    @chairman = Teacher.find_by(id: @council.chairman)
    @commissioner = Teacher.find_by(id: @council.commissioner)
    @secretary = Teacher.find_by(id: @council.secretary)
  end
end
