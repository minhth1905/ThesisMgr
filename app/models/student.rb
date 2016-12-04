class Student < ActiveRecord::Base
  belongs_to :user
  belongs_to :department
  belongs_to :training
  belongs_to :course

  def self.import_student(student_hash)
    student_value = find_by(user_id: student_hash["user_id"]) || new
    student_value.attributes = student_hash.to_hash.slice(*student_hash.to_hash.keys)
    student_value.save
  end

  def self.update_status(students)
    students.each do |student|
      update = find_by(user_id: student)
      if update
        update.update_attributes(status: 1)
      end
    end
  end
end
