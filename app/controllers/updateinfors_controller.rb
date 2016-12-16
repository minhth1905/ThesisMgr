class UpdateinforsController < ApplicationController
  before_action :teacher
  skip_before_action :verify_authenticity_token
  def index
    @researches = current_user.teacher.researches
  end

  def show
  end

  def new
    @list_tree_spheres = show_tree_spheres()
  end

  def create
    @research = Research.new(name: params[:name], description: params[:description], teacher_id: current_user.teacher.id)
    if @research.save
      if params[:sphere_array_id]
        params[:sphere_array_id].each do |item|
          Searchsphere.create(research_id: @research.id, sphere_id: item)
        end
      end
      flash[:success] = "Thêm chủ đề hướng nghiên cứu thành công"
      redirect_to home_path(check: 1)
    else
      flash[:danger] = "Thêm chủ đề hướng nghiên cứu thất bại"
      render :new
    end
  end
end
