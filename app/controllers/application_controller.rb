class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception



  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in)        << :code
    devise_parameter_sanitizer.for(:sign_up)        << :code
    devise_parameter_sanitizer.for(:account_update) << :code
  end

  def after_sign_in_path_for(resource)
    home_path #your path
  end

  def user_signin
    if user_signed_in?
      return true
    else
      redirect_to root_url
    end
  end

  def admin
    if user_signed_in?
      if current_user.rules == Settings.admin_role
        return true
      else
        redirect_to root_url
      return false
      end
    else
      redirect_to root_url
    end

  end

  def department
    if user_signed_in?
      if current_user.rules == Settings.department_role
        return true
      else
        redirect_to root_url
      return false
      end
    else
      redirect_to root_url
    end
  end

  def admin_department
    if user_signed_in?
      if current_user.rules == Settings.department_role || current_user.rules == Settings.admin_role
        return true
      else
        redirect_to root_url
      return false
      end
    else
      redirect_to root_url
    end
  end

   def teacher
    if user_signed_in?
      if current_user.rules == Settings.teacher_role
        return true
      else
        redirect_to root_url
      return false
      end
    else
      redirect_to root_url
    end
  end

   def student
    if user_signed_in?
      if current_user.rules == Settings.student_role
        return true
      else
        redirect_to root_url
      return false
      end
    else
      redirect_to root_url
    end
  end

  def show_tree(data, parent_id, level)
    @result = []
    data.each do | item|
      if(item.parent_id == parent_id)
        item.level = level
        @result << item

        data.each do |item_2 |
          if(item_2.parent_id == item.id)
            item_2.level = level + 1
            @result << item_2
          end
        end
        # @result_child = show_tree(data,item.id,level + 1)
        # @result << @result_child

      end
    end
    # byebug
    return @result

  end
end
