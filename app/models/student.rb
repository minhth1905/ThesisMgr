class Student < ActiveRecord::Base
  belongs_to :user
  belongs_to :department
  belongs_to :training
  belongs_to :course
end
