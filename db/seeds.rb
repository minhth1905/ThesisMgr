# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
# #
# # Examples:
# #
# #   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
# #   Mayor.create(name: 'Emanuel', city: cities.first)

# 10.times do |i|
#   departments = Department.new(name: "Khoa #{i + 1}", office: "Văn phòng #{i + 1}")
#   departments.save
#   id = departments.id
#   10.times do |f|
#     Subject.create(name: "Bộ môn #{f + 1},  Khoa #{i + 1}", department_id: id)
#   end

#   10.times do |f|
#     Lab.create(name: "Phòng thí nghiệm #{f + 1},  Khoa #{i + 1}", department_id: id)
#   end
# end

# 10.times do |i|
#   courses = Course.new(name: "K#{i + 50}")
#   courses.save
#   id = courses.id
#   Training.create(name: "Chinh quy", course_id: id)
#   Training.create(name: "Chat luong cao", course_id: id)
#   Training.create(name: "Chuan quoc te", course_id: id)
# end

# user = User.new(rules: 2, code: 123, first_name: "Khoa", last_name: "Account", email: "minhth1905@hotmail.com", password: "cubin1905")
# user.save
# id_user = user.id
# Departmentuser.create(job_title: "Quan ly", user_id: id_user, department_id: 1)

# users = User.new(rules: 1, code: 12, first_name: "Handsome", last_name: "Admin", email: "admin@gmail.com", password: "cubin1905")
# users.save
# id_users = users.id
# Admin.create(job_title: "admin", user_id: id_users)

# user_teacher = User.new(rules: 3, code: 1234, first_name: "Giang", last_name: "Vien", email: "teacher@gmail.com", password: "cubin1905")
# user_teacher.save
# id_teacher = user_teacher.id
# Teacher.create(description: "giangvien", user_id: id_teacher, department_id: 1, subject_id: 1)

# user_student = User.new(rules: 4, code: 12345, first_name: "Sinh", last_name: "Vien", email: "student@gmail.com", password: "cubin1905")
# user_student.save
# id_student = user_student.id
# Student.create(user_id: id_student, department_id: 1, training_id: 1, course_id: 1)

# user = User.new(rules: 1, code: 12, first_name: "Handsome", last_name: "Admin", email: "admin@gmail.com", password: "cubin1905")
# user.save
# id_user = user.id
# Admin.create(job_title: "admin", user_id: id_user)
# #seed sinh vien giao vien
# Course.create(name: "QH-2014")
# Training.create(name: "CNTT", description: "", course_id: 1)
# 20.times do |t|
#   user_student=User.new(rules: 4, code: "#{t + 30}", first_name: "sinh vien", last_name: "#{t + 1}",
#     email: "phong#{t}@gmail.com", password: "cubin1905")
#   user_student.save
#   user_id = user_student.id
#   student = Student.new(status: "1", user_id: user_id, department_id: 1, training_id: 1, course_id: 1)
#   student.save
#   student_id = student.id
#   topic = Topic.new(name: "Detai#{t + 1}", student_id: student_id, status: 0, description: "Mo ta#{t+1}")
#   topic.save
# end
# 20.times do |t|
#   user_teacher1 = User.new(rules: 3, code: "#{t+400}", first_name: "giao vien", last_name: "#{t+1}",
#   email: "giaovien#{t}@gmail.com", password: "cubin1905")
#   user_teacher1.save
#   user_teacher_id_1 = user_teacher1.id
#   teacher1 = Teacher.new(user_id: user_teacher_id_1, department_id: 1, subject_id: 1)
#   teacher1.save
#   teacher_id_1 = teacher1.id
#   user_teacher2 = User.new(rules: 3, code: "#{t+200}", first_name: "giao vien dong huong dan", last_name: "#{t+1}",
#   email: "giaoviendong#{t}@gmail.com", password: "123456")
#   user_teacher2.save
#   user_teacher_id_2 = user_teacher2.id
#   teacher2 = Teacher.new(user_id: user_teacher_id_2, department_id: 1)
#   teacher2.save
#   teacher_id_2 = teacher2.id
#   Division.create(teacher_id: 1, topic_id: t +1)
# end

# 20.times do |i|
#   info = Info.new(content: "aaaa#{i}", status: "0", user_send: "4", user_receive: "1")
#   info.save
# end
# 5.times do |i|
#   info = Info.new(content: "aaaa#{i}", status: "1", user_send: "5", user_receive: "1")
#   info.save
# end




# seed khoa
Dir[File.join(Rails.root, 'db', 'seeds', 'seed_department_1.rb')].sort.each { |seed| load seed }

# seed khoa hoc, ct dao tao
Dir[File.join(Rails.root, 'db', 'seeds', 'seed_course_2.rb')].sort.each { |seed| load seed }

#seed linh vuc
Dir[File.join(Rails.root, 'db', 'seeds', 'seed_sepheres_4.rb')].sort.each { |seed| load seed }

# seed tai khoan
Dir[File.join(Rails.root, 'db', 'seeds', 'seed_accounts_3.rb')].sort.each { |seed| load seed }

#seed teacher
Dir[File.join(Rails.root, 'db', 'seeds', 'seed_teachers_5.rb')].sort.each { |seed| load seed }

#seed topic module 4
Dir[File.join(Rails.root, 'db', 'seeds', 'seed_topic_6.rb')].sort.each { |seed| load seed }

#seed topic_7 module 5
Dir[File.join(Rails.root, 'db', 'seeds', 'seed_topic_7.rb')].sort.each { |seed| load seed }
