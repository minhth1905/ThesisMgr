10.times do |t|
  User.create(id: 400 + t, rules: 4, code: "#{t + 30}", first_name: "sinh vien", last_name: "#{t + 1}",
    email: "phong#{t}@gmail.com", password: "cubin1905")

  Student.create(id: 600 + t, status: "1", user_id: 400 + t, department_id: 1, training_id: 1, course_id: 1)

  topic = Topic.new(id: 30 + t ,name: "Detai#{t + 1}", student_id: 600 + t, status: 1, description: "Mo ta#{t+1}", is_proteced: nil)
  topic.save
end

10.times do |t|
  User.create(id: 500 + t, rules: 3, code: "#{t+400}", first_name: "giao vien", last_name: "#{t+1}",
  email: "giaovien#{t}@gmail.com", password: "cubin1905")

  Teacher.create(id: 700 + t ,user_id: 500 + t, department_id: 1, subject_id: 1)
  User.create(id: 800 + t, rules: 3, code: "#{t+200}", first_name: "giao vien dong huong dan", last_name: "#{t+1}",
  email: "giaoviendong#{t}@gmail.com", password: "123456")
  Teacher.create(id: 900 + t ,user_id: 800 + t, department_id: 1)
  Division.create(teacher_id: 1, topic_id: 30 + t)
end
