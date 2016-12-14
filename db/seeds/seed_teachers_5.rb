user_teacher = User.new(rules: 3, code: 12345678, first_name: "Bùi Ngọc", last_name: "Hải", email: "teacher10@gmail.com", password: "cubin1905")
user_teacher.save
id_teacher = user_teacher.id
teacher = Teacher.new(description: "giangvien", user_id: id_teacher, department_id: 1, subject_id: 1)
teacher.save
id = teacher.id

research11 = Research.new(name: "Tối ưu hóa hệ thống nhúng", description: "Tối ưu hóa hệ thống nhúng", teacher_id: id)
research11.save
id_research11 = research11.id
Searchsphere.create(sphere_id: 1, research_id: id_research11)

research12 = Research.new(name: "Công nghệ phần mềm nhúng", description: "Công nghệ phần mềm nhúng", teacher_id: id)
research12.save
id_research12 = research12.id
Searchsphere.create(sphere_id: 2, research_id: id_research12)


research13 = Research.new(name: "Phương pháp giảm điện năng tiêu thụ trên các bộ xử lý", description: "Phương pháp giảm điện năng tiêu thụ trên các bộ xử lý", teacher_id: id)
research13.save
id_research13 = research13.id
Searchsphere.create(sphere_id: 3, research_id: id_research13)

#Giang vien 2

user_teacher1 = User.new(rules: 3, code: 123456789, first_name: "Bùi Ngọc", last_name: "Thăng", email: "teacher1@gmail.com", password: "cubin1905")
user_teacher1.save
id_teacher1 = user_teacher1.id
teacher1 = Teacher.new(description: "giangvien", user_id: id_teacher1, department_id: 1, subject_id: 1)
teacher1.save
id1 = teacher1.id

research21 = Research.new(name: "Học máy", description: "Học máy", teacher_id: id1)
research21.save
id_research21 = research21.id
Searchsphere.create(sphere_id: 2, research_id: id_research21)

research22 = Research.new(name: "tin sinh học", description: "tin sinh học", teacher_id: id1)
research22.save
id_research22 = research22.id
Searchsphere.create(sphere_id: 3, research_id: id_research22)


research23 = Research.new(name: "Hạ tầng dữ liệu không gian", description: "Hạ tầng dữ liệu không gian", teacher_id: id1)
research23.save
id_research23 = research23.id
Searchsphere.create(sphere_id: 4, research_id: id_research23)

#Giang vien 3

user_teacher2 = User.new(rules: 3, code: 1234567810, first_name: "Bùi Quang", last_name: "Hưng", email: "teacher22@gmail.com", password: "cubin1905")
user_teacher2.save
id_teacher2 = user_teacher2.id
teacher2 = Teacher.new(description: "giangvien", user_id: id_teacher2, department_id: 2, subject_id: 1)
teacher2.save
id2 = teacher2.id

research31 = Research.new(name: "Học máy", description: "Học máy", teacher_id: id2)
research31.save
id_research31 = research31.id
Searchsphere.create(sphere_id: 2, research_id: id_research31)

research32 = Research.new(name: "tin sinh học", description: "tin sinh học", teacher_id: id2)
research32.save
id_research32 = research32.id
Searchsphere.create(sphere_id: 3, research_id: id_research32)


research33 = Research.new(name: "Hạ tầng dữ liệu không gian", description: "Hạ tầng dữ liệu không gian", teacher_id: id2)
research33.save
id_research33 = research33.id
Searchsphere.create(sphere_id: 4, research_id: id_research33)


#Giang vien 4

user_teacher3 = User.new(rules: 3, code: 1234567811, first_name: "Dư Phương", last_name: "Hạnh", email: "teacher3@gmail.com", password: "cubin1905")
user_teacher3.save
id_teacher3 = user_teacher3.id
teacher3 = Teacher.new(description: "giangvien", user_id: id_teacher3, department_id: 2, subject_id: 1)
teacher3.save
id3 = teacher3.id

research41 = Research.new(name: "Quan lý dữ liệu không gian", description: "Quan lý dữ liệu không gian", teacher_id: id3)
research41.save
id_research41 = research41.id
Searchsphere.create(sphere_id: 3, research_id: id_research41)

research42 = Research.new(name: "Tối ưu hóa truy vấn", description: "Tối ưu hóa truy vấn", teacher_id: id3)
research42.save
id_research42 = research42.id
Searchsphere.create(sphere_id: 4, research_id: id_research42)


research43 = Research.new(name: "Cơ sở dữ liệu quy mô lớn", description: "Cơ sở dữ liệu quy mô lớn", teacher_id: id3)
research43.save
id_research43 = research43.id
Searchsphere.create(sphere_id: 5, research_id: id_research43)
