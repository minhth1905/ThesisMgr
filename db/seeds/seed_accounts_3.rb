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

user_teacher = User.new(rules: 3, code: 123410, first_name: "Giang", last_name: "Vien Đồng Hướng dẫn", email: "teacher2@gmail.com", password: "cubin1905")
user_teacher.save
id_teacher = user_teacher.id
Teacher.create(description: "giangvien", user_id: id_teacher, department_id: 1, subject_id: 1)

user_student = User.new(rules: 4, code: 12345, first_name: "Sinh", last_name: "Vien", email: "student@gmail.com", password: "cubin1905")
user_student.save
id_student = user_student.id
Student.create(user_id: id_student, department_id: 1, training_id: 1, course_id: 1)

user_student = User.new(rules: 4, code: 1234510, first_name: "Sinh", last_name: "Vien 2", email: "student2@gmail.com", password: "cubin1905")
user_student.save
id_student = user_student.id
Student.create(user_id: id_student, department_id: 1, training_id: 1, course_id: 1)
