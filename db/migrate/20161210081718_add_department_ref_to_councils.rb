class AddDepartmentRefToCouncils < ActiveRecord::Migration
  def change
    add_reference :councils, :department, index: true, foreign_key: true
  end
end
