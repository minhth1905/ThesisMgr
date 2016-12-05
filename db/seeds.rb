# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do |i|
  departments = Department.new(name: "Khoa #{i + 1}", office: "Văn phòng #{i + 1}")
  departments.save
  id = departments.id
  10.times do |f|
    Subject.create(name: "Bộ môn #{f + 1},  Khoa #{i + 1}", department_id: id)
  end

  10.times do |f|
    Lab.create(name: "Phòng thí nghiệm #{f + 1},  Khoa #{i + 1}", department_id: id)
  end
end

10.times do |i|
  courses = Course.new(name: "K#{i + 50}")
  courses.save
  id = courses.id
  Training.create(name: "Chinh quy", course_id: id)
  Training.create(name: "Chat luong cao", course_id: id)
  Training.create(name: "Chuan quoc te", course_id: id)
end

user = User.new(rules: 2, code: 123, first_name: "Khoa", last_name: "Account", email: "minhth1905@hotmail.com", password: "cubin1905")
user.save
id_user = user.id
Departmentuser.create(job_title: "Quan ly", user_id: id_user, department_id: 1)

users = User.new(rules: 1, code: 12, first_name: "Handsome", last_name: "Admin", email: "admin@gmail.com", password: "cubin1905")
users.save
id_users = users.id
Admin.create(job_title: "admin", user_id: id_users)

user_teacher = User.new(rules: 3, code: 1234, first_name: "Giang", last_name: "Vien", email: "teacher@gmail.com", password: "cubin1905")
user_teacher.save
id_teacher = user_teacher.id
Teacher.create(description: "giangvien", user_id: id_teacher, department_id: 1, subject_id: 1)

user_student = User.new(rules: 4, code: 12345, first_name: "Sinh", last_name: "Vien", email: "student@gmail.com", password: "cubin1905")
user_student.save
id_student = user_student.id
Student.create(user_id: id_student, department_id: 1, training_id: 1, course_id: 1)
