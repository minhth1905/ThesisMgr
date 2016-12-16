# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
# #
# # Examples:
# #
# #   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
# #   Mayor.create(name: 'Emanuel', city: cities.first)


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

#seed info
Dir[File.join(Rails.root, 'db', 'seeds', 'seed_infor_8.rb')].sort.each { |seed| load seed }

#seed topic_7 module 5
Dir[File.join(Rails.root, 'db', 'seeds', 'seed_topic_7.rb')].sort.each { |seed| load seed }
