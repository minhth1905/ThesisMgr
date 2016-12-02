class AddDepartmentToLabs < ActiveRecord::Migration
  def change
    add_reference :labs, :department, index: true, foreign_key: true
  end
end
