class Admin::SpheresController < ApplicationController
  def index
    @spheres = Sphere.all
  end
end
