class Sphere < ActiveRecord::Base
  has_many :searchspheres
  attr_accessor :level
end
