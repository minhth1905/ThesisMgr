class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         validates :email, uniqueness: true
  validates :email, presence: true
  validates :email, length: {maximum: 75}
  devise :database_authenticatable, :validatable, password_length: 6..128
end
