class StaticPagesController < ApplicationController
  before_action :user_signin
  def index
    if params[:check] != "1" && current_user.rules == Settings.teacher_role
      if current_user.sign_in_count <= 1
        redirect_to edit_teacher_path(current_user.id, check: 1)
      end
    end
  end

  def home
  end
end
