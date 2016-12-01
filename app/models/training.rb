class Training < ActiveRecord::Base
  has_many :students
  belongs_to :course
end
