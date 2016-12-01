class Teacher < ActiveRecord::Base
  belongs_to :user
  belongs_to :department
  belongs_to :subject
  has_many :divisions
  has_many :researchs


  def self.import(file)
    colum = Settings.column_user
    spreadsheet = open_spreadsheet(file)
    total_colum = spreadsheet.last_column
    headers = []
    header = spreadsheet.row(1)

    (colum - 1..total_colum-1).each do |r|
      headers << header[r]
    end
    (2..spreadsheet.last_row).each do |i|
      rows = []
      data = spreadsheet.row(i)
      (colum - 1..total_colum-1).each do |r|
        rows << data[r]
      end
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
