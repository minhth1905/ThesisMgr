class Teacher < ActiveRecord::Base
  belongs_to :user
  belongs_to :department
  belongs_to :subject
  has_many :divisions
  has_many :researchs
end
