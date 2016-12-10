class Review < ActiveRecord::Base
  belongs_to :topic
  belongs_to :teacher
end
