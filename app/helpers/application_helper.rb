module ApplicationHelper
  def info
    return Info.where("user_id = ?", current_user.id).count
  end
end
