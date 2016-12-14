class Review < ActiveRecord::Base
  belongs_to :topic
  belongs_to :teacher

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    number = spreadsheet.last_row - 1
    (2..spreadsheet.last_row).each do |i|
      data = spreadsheet.row(i)
      code = data[0]
      student = User.find_by(code: code)
      teacher1 = find_teacher(data[4])
      teacher2 = find_teacher(data[5])
      if teacher1.nil?
      else
        @review1 = Review.where(topic_id: student.student.topic.id)
        if @review1[0].blank?
          Review.create(teacher_id: teacher1.teacher.id, topic_id: student.student.topic.id)
        else
          @review1[0].update_attributes(teacher_id: teacher1.teacher.id, topic_id: student.student.topic.id)
        end
      end
      if teacher2.nil?
      else
        if teacher2.nil?
        else
          if @review1[1].blank?
            Review.create(teacher_id: teacher2.teacher.id, topic_id: student.student.topic.id)
          else
            @review1[1].update_attributes(teacher_id: teacher2.teacher.id, topic_id: student.student.topic.id)
          end
        end
      end

      if teacher1.nil? && teacher2.nil?
        number = number - 1
      end
    end
    if number < spreadsheet.last_row - 1
      return 0
    else
      return 1
    end
  end

  def self.find_teacher(name)
    if name.nil?
      return nil
    else
      student = User.find_by(code: name)
      if student.blank?
        names = name.split(" ")
        student = User.find_by(first_name: names[0], last_name: names[1])
        if student.blank?
          return 0
        end
      end
      return student
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.xls' then Roo::Excel.new(file.path, packed: false, file_warning: :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, packed: false, file_warning: :ignore)
    else raise "Unknown file type"
    end
  end
end
