class Topic < ActiveRecord::Base
  belongs_to :student
  has_many :divisions
  has_many :reviews
  has_one :report
end
