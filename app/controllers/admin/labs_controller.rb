class Admin::LabsController < ApplicationController
  before_action :admin_department only:, only: [:edit, :new, :update, :destroy]
  before_action :find_lab, only: [:show, :edit, :update, :destroy]
  def index
    @labs = Lab.all
  end

  def show
  end

  def new
    @lab = Lab.new
  end

  def create
    @lab = Lab.new(lab_params)
    if @lab.save
      redirect_to admin_labs_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @lab.update_attributes(lab_params)
      redirect_to admin_labs_path
    else
      render :edit
    end
  end

  def destroy
    if @lab.destroy
      redirect_to admin_labs_path
    else
      redirect_to admin_labs_path
    end
  end

  private
  def lab_params
    params.require(:lab).permit(:name, :department_id)
  end

  def find_lab
    @lab = Lab.find_by(id: params[:id])
  end
end
