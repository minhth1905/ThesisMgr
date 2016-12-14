user = User.new(rules: 2, code: 123, first_name: "Khoa", last_name: "Account", email: "minhth1905@hotmail.com", password: "cubin1905")
user.save
id_user = user.id
Departmentuser.create(job_title: "Quan ly", user_id: id_user, department_id: 1)

users = User.new(rules: 1, code: 12, first_name: "Handsome", last_name: "Admin", email: "admin@gmail.com", password: "cubin1905")
users.save
id_users = users.id
Admin.create(job_title: "admin", user_id: id_users)

user_teacher = User.new(rules: 3, code: 1234, first_name: "Dương Lê", last_name: "Minh", email: "teacher@gmail.com", password: "cubin1905")
user_teacher.save
id_teacher = user_teacher.id
teacher2 = Teacher.new(description: "giangvien", user_id: id_teacher, department_id: 1, subject_id: 1)
teacher2.save
id2 = teacher2.id
research31 = Research.new(name: "Mạng adhoc không dây", description: "Mạng adhoc không dây", teacher_id: id2)
research31.save
id_research31 = research31.id
Searchsphere.create(sphere_id: 2, research_id: id_research31)

research32 = Research.new(name: "SIP - based VoIP", description: "SIP - based VoIP", teacher_id: id2)
research32.save
id_research32 = research32.id
Searchsphere.create(sphere_id: 3, research_id: id_research32)


research33 = Research.new(name: "Internet of Things", description: "Internet of Things", teacher_id: id2)
research33.save
id_research33 = research33.id
Searchsphere.create(sphere_id: 4, research_id: id_research33)


user_teacher = User.new(rules: 3, code: 12342, first_name: "Hoàng Xuân", last_name: "Huấn", email: "teacher2@gmail.com", password: "cubin1905")
user_teacher.save
id_teacher = user_teacher.id
teacher3 = Teacher.new(description: "giangvien", user_id: id_teacher, department_id: 1, subject_id: 1)
teacher3.save
id3 = teacher3.id

research41 = Research.new(name: "Tính toán mềm", description: "tính toán mềm", teacher_id: id3)
research41.save
id_research41 = research41.id
Searchsphere.create(sphere_id: 3, research_id: id_research41)

research42 = Research.new(name: "Các ứng dụng mobile và cloud", description: "Các ứng dụng mobile và cloud", teacher_id: id3)
research42.save
id_research42 = research42.id
Searchsphere.create(sphere_id: 4, research_id: id_research42)


research43 = Research.new(name: "Dánh giá hiệu năng hệ thống", description: "đánh giá hiệu năng hệ thống", teacher_id: id3)
research43.save
id_research43 = research43.id
Searchsphere.create(sphere_id: 5, research_id: id_research43)


user_student = User.new(rules: 4, code: 12345, first_name: "Sinh", last_name: "Vien", email: "student@gmail.com", password: "cubin1905")
user_student.save
id_student = user_student.id
Student.create(user_id: id_student, department_id: 1, training_id: 1, course_id: 1, status: 1)

user_student = User.new(rules: 4, code: 1234510, first_name: "Sinh", last_name: "Vien 2", email: "demosachmem@gmail.com", password: "cubin1905")
user_student.save
id_student = user_student.id
Student.create(user_id: id_student, department_id: 1, training_id: 1, course_id: 1, status: 1)
