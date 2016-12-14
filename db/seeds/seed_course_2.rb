10.times do |i|
  courses = Course.new(name: "K#{i + 50}")
  courses.save
  id = courses.id
  Training.create(name: "Chinh quy", course_id: id)
  Training.create(name: "Chat luong cao", course_id: id)
  Training.create(name: "Chuan quoc te", course_id: id)
end
