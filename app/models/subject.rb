class Subject < ActiveRecord::Base
  belongs_to :department
  has_many :teachers
end
