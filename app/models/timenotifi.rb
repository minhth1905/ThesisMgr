class Timenotifi < ActiveRecord::Base
  belongs_to :department

  def self.auto_close(id)
    find_by(id: id).update_attributes(status: 0)
  end
end
