class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception



  protected

  def configure_permitted_parameters
    added_attrs = [:code, :email, :password, :password_confirmation, :remember_me,
     :avatar, :avatar_cache]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
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

  # def show_tree(data, parent_id, level)
  #   @result = []
  #   data.each do | item|
  #     if(item.parent_id == parent_id)
  #       item.level = level
  #       # item.update_attributes(:level => level)
  #       @result = @result << item

  #       data.each do |item_2 |
  #         if(item_2.parent_id == item.id)
  #           item_2.level = level + 1
  #           @result << item_2

  #           data.each do |item_3 |
  #             if(item_3.parent_id == item_2.id)
  #               item_3.level = level + 2
  #               @result << item_3
  #             end

  #             # data.each do |item_4 |
  #             #   if(item_4.parent_id == item_3.id)
  #             #     item_4.level = level + 3
  #             #     @result << item_4

  #             #     data.each do |item_5 |
  #             #       if(item_5.parent_id == item_4.id)
  #             #         item_5.level = level + 4
  #             #         @result << item_5
  #             #       end
  #             #     end
  #             #   end
  #             # end
  #           end
  #         end
  #       end
  #       # @result_child = show_tree(data,item.id,level + 1)
  #       # @result = @result << @result_child
  #       # byebug

  #     end
  #   end
  #   return @result
  # end

  def show_tree_spheres(children_array = [],parent_id = 0, level = 0)
    children = Sphere.where(parent_id: parent_id)
    children.each do |child|
      child.level = level
      children_array << child
      # recursion
      show_tree_spheres(children_array,child.id,level+1)
    end
    return children_array
  end

end
