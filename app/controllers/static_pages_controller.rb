class StaticPagesController < ApplicationController
  before_action :user_signin
  def index
  end

  def home
  end
end
