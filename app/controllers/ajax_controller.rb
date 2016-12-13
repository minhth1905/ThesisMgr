class AjaxController < ApplicationController
  include ApplicationHelper
  def update_info_status
    if(params[:user_id])
      @infos = Info.where("user_receive = ?",params[:user_id])
      @infos.each do |item|
        item.update_attributes(status: 0)
      end
      @arr = "thanh cong"
      respond_to do |format|
        format.html
        format.text {render json: @arr}
      end
    end
  end

  def get_info
    if(params[:user_id])
      @infos = Info.where("user_receive = ?",params[:user_id]).limit(params[:number_info].to_i + 3)
      @arr = {}
      s = ''
      @infos.each do |info|
        s += '<li>'
        s +=   '<a>'
        s +=     '<span class="image"><img src="assets/img.jpg"></span>'
        s +=    '<span>'
        s +=       '<span>' + get_user_send_name(info.user_send) + '</span>'
        s +=       '<span class="time">3 mins ago</span>'
        s +=     '</span>'
        s +=     '<span class="message">' + info.content + '</span>'
        s +=   '</a>'
        s += '</li>'
      end
      s += '<div id="loading-content"></div>'
      if(Info.where("user_receive = ?",params[:user_id]).count > params[:number_info].to_i)
        s += '<li id="loading" style="background: #fff; text-align: center; padding: 6px;">'
        s +=   '<img src="/loading.gif" alt="Loading…"  style="height: 100%; width:auto; overflow: hidden" />'
        s += '</li>'
      end
      @arr.store("content",s)
      @arr.store("number_info", @infos.size)
      respond_to do |format|
        format.html
        format.text {render json: @arr}
      end
    end
  end
end
