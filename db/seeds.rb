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
