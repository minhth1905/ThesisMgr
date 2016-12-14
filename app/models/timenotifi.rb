class Timenotifi < ActiveRecord::Base
  belongs_to :department

  def self.auto_close(id, current_user)
    find_by(id: id).update_attributes(status: 2)
    Notification.where("department_id = ?", current_user.departmentuser.department.id).destroy_all
      Notification.create(content: "đã đóng hệ thống đăng kí", status: "1", department_id: current_user.departmentuser.department_id)
      Pusher.trigger('notifications-of-department-' + current_user.departmentuser.department_id.to_s, 'new_notification', {
          message: current_user.departmentuser.department.name.to_s + " đã đóng hệ thống đăng kí."
      })
  end
end
