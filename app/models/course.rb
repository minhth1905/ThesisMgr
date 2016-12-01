class Course < ActiveRecord::Base
  has_many :students
end
