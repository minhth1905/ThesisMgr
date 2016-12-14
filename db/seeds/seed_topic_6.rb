topic = Topic.new(name: "Angularjs 2 with Ruby on rails",
  description: "Angularjs 2 with Ruby on rails", status: 1,
  student_id: 2)
topic.save
id = topic.id
Division.create(teacher_id: 1, topic_id: id)
