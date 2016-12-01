class Department < ActiveRecord::Base
  has_many :subjects
  has_many :departmentusers
  has_many :students
  has_many :teachers
end
