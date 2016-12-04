class Research < ActiveRecord::Base
  belongs_to :teacher
  has_many :seachrspheres
end
