class Departmentuser < ActiveRecord::Base
  belongs_to :department
  belongs_to :user

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      # binding.pry
      decoration = find_by_id(row["id"]) || new
      decoration.attributes = row.to_hash.slice(*row.to_hash.keys)
      decoration.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then Roo::Csv.new(file.path, nil, :ignore)
    when '.xls' then Roo::Excel.new(file.path, packed: false, file_warning: :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path, packed: false, file_warning: :ignore)
    else raise "Unknown file type"
    end
  end
end
