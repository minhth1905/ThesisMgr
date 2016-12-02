class User < ActiveRecord::Base
  has_one :admin
  has_one :student
  has_one :teacher
  has_one :departmentuser
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def self.import(file)
    colum = Settings.column_user
    spreadsheet = open_spreadsheet(file)
    headers = []
    header_teacher = []
    header = spreadsheet.row(1)
    headers << "rules"

    (0..colum - 1).each do |r|
      headers << header[r]
    end

    (colum..spreadsheet.last_column - 1).each do |t|
      header_teacher << header[t]
    end
    header_teacher << "user_id"
    headers << "password"
    (2..spreadsheet.last_row).each do |i|
      rows = []
      teacher = []
      rows << "3".to_i
      data = spreadsheet.row(i)

      (0..colum - 1).each do |r|
        rows << data[r]
      end

      (colum..spreadsheet.last_column - 1).each do |t|
        teacher << data[t]
      end

      rows << "123456"
      row = Hash[[headers, rows].transpose]
      decoration = find_by(email: row["email"]) || new
      decoration.attributes = row.to_hash.slice(*row.to_hash.keys)
      decoration.save!
      id_user = decoration.id

      teacher << id_user
      teacher_hash = Hash[[header_teacher, teacher].transpose]
      Teacher.import_teacher(teacher_hash)

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
