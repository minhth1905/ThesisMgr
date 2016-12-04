class User < ActiveRecord::Base
  has_one :admin, dependent: :destroy
  has_one :student, dependent: :destroy
  has_one :teacher, dependent: :destroy
  has_one :departmentuser, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def self.import(file, department_id)
    colum = Settings.column_user
    total_id = []
    spreadsheet = open_spreadsheet(file)
    headers = []
    header_teacher = []
    header = spreadsheet.row(1)
    headers << "rules"

    (0..colum - 1).each do |r|
      headers << header[r]
    end
    headers << "password"

    (colum..spreadsheet.last_column - 1).each do |t|
      header_teacher << header[t]
    end

    header_teacher << "user_id"
    header_teacher << "department_id"
    # header_teacher << "subject_id"

    (2..spreadsheet.last_row).each do |i|
      password = rand(100000..999999)
      rows = []
      teacher = []
      rows << Settings.teacher_role
      data = spreadsheet.row(i)

      (0..colum - 1).each do |r|
        rows << data[r]
      end

      (colum..spreadsheet.last_column - 1).each do |t|
        teacher << data[t]
      end

      rows << password.to_s #password
      row = Hash[[headers, rows].transpose]
      decoration = find_by(email: row["email"]) || new
      decoration.attributes = row.to_hash.slice(*row.to_hash.keys)
      decoration.save!
      id_user = decoration.id
      total_id << id_user

      teacher << id_user
      teacher << department_id
      teacher_hash = Hash[[header_teacher, teacher].transpose]
      # byebug

      if check_subject(teacher_hash["subject_id"])
        subject = check_subject(teacher_hash["subject_id"])
        teacher_hash["subject_id"] = subject.id

        teacher_hash["department_id"] = department_id
      else
        teacher_hash["subject_id"] = ""

        teacher_hash["department_id"] = department_id
      end

      Teacher.import_teacher(teacher_hash)
    end
    return total_id
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.xls' then Roo::Excel.new(file.path, packed: false, file_warning: :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, packed: false, file_warning: :ignore)
    else raise "Unknown file type"
    end
  end

  def self.check_subject(subject_name)
    subject = Subject.find_by(name: subject_name)
    return subject
  end

  def self.new_teacher(first_name, last_name, code, email, description,subject_id, department_id)
    header = []
    header << "first_name"
    header << "last_name"
    header << "code"
    header << "email"
    header << "password"
    header << "rules"


    content = []
    content << first_name
    content << last_name
    content << code
    content << email
    content << "password"
    content << Settings.teacher_role


    user_hash = Hash[[header, content].transpose]
    decoration = find_by(email: user_hash["email"]) || new
    decoration.attributes = user_hash.to_hash.slice(*user_hash.to_hash.keys)
    decoration.save!
    id_user = decoration.id

    header_teacher = []
    content_teacher = []
    header_teacher << "description"
    header_teacher << "user_id"
    header_teacher << "subject_id"
    header_teacher << "department_id"
    content_teacher << description
    content_teacher << id_user
    content_teacher << subject_id
    content_teacher << department_id
    teacher_hash = Hash[[header_teacher, content_teacher].transpose]
    Teacher.import_teacher(teacher_hash)
    return id_user
  end
end
