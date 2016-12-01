class Research < ActiveRecord::Base
  belongs_to :teacher
  has_many :seachrsphere
end
