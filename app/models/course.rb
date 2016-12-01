class Course < ActiveRecord::Base
  has_many :students, dependent: :destroy
  has_many :trainings, dependent: :destroy
end
