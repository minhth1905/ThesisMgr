class Topic < ActiveRecord::Base
  belongs_to :student
  has_many :divisions
end
