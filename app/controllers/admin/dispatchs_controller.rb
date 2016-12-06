class Admin::DispatchsController < ApplicationController
  respond_to :docx
  def file
    @students = Student.where(status: 1)
    respond_to do |format|
      format.docx do
        render docx: 'words', filename: 'congvan.docx'
      end
    end
  end
  def index
    @students = Student.where(status: 1)
  end
end
