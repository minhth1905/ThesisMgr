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
    header = spreadsheet.row(1)

    (0..colum - 1).each do |r|
      headers << header[r]
    end
    headers << "password"
    (2..spreadsheet.last_row).each do |i|
      rows = []
      data = spreadsheet.row(i)
      (0..colum - 1).each do |r|
        rows << data[r]
      end
      rows << "123456"
      row = Hash[[headers, rows].transpose]
      decoration = find_by_id(row["id"]) || new
      decoration.attributes = row.to_hash.slice(*row.to_hash.keys)
      decoration.save!
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
