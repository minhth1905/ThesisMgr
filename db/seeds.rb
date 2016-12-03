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

user = User.new(rules: 2, first_name: "Khoa", last_name: "Account", email: "minhth1905@hotmail.com", password: "cubin1905")
user.save
id_user = user.id
Departmentuser.create(job_title: "Quan ly", user_id: id_user, department_id: 1)

user = User.new(rules: 1, first_name: "Handsome", last_name: "Admin", email: "admin@gmail.com", password: "cubin1905")
user.save
id_user = user.id
Admin.create(job_title: "admin", user_id: id_user)
