class Teacher < ActiveRecord::Base
  belongs_to :user
  belongs_to :department
  belongs_to :subject
  has_many :divisions
  has_many :researches


  def self.import_teacher(teacher_hash)
    teacher_value = find_by(user_id: teacher_hash["user_id"]) || new
    teacher_value.attributes = teacher_hash.to_hash.slice(*teacher_hash.to_hash.keys)
    teacher_value.save
  end
end
