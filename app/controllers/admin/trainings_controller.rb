class Admin::TrainingsController < ApplicationController
   before_action :find_training, only: [:show, :edit, :update, :destroy]
  def index
    @trainings = Training.all
  end

  def show
  end

  def new
    @training = Training.new
  end

  def create
    @training = Training.new(training_params)
    if @training.save
      redirect_to admin_trainings_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @training.update_attributes(training_params)
      redirect_to [:admin, @training]
    else
      render :edit
    end
  end

  def destroy
    if @training.destroy
      redirect_to admin_trainings_path
    else
      redirect_to admin_trainings_path
    end
  end

  private
  def training_params
    params.require(:training).permit(:name, :description, :course_id)
  end

  def find_training
    @training = Training.find_by(id: params[:id])
  end
end
