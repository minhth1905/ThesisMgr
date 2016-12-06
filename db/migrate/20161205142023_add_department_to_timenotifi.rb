class AddDepartmentToTimenotifi < ActiveRecord::Migration
  def change
    add_reference :timenotifis, :department, index: true, foreign_key: true
  end
end
