class User < ActiveRecord::Base
  has_one :admin
  has_one :student
  has_one :teacher
  has_one :departmentuser
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
