module ApplicationHelper
  def get_new_info_number
    return Info.where("user_receive = ? AND status = 1", current_user.id).count
  end

  def get_info
    return Info.where("user_receive = ?", current_user.id).order('id DESC').limit(5)
  end

  def get_user_send_name(id)
    @user =  User.find_by(id: id)
    return @user.first_name
  end

end
