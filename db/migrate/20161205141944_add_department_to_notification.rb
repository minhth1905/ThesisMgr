class AddDepartmentToNotification < ActiveRecord::Migration
  def change
    add_reference :notifications, :department, index: true, foreign_key: true
  end
end
