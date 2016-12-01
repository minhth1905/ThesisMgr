class AddCourseToTrainings < ActiveRecord::Migration
  def change
    add_reference :trainings, :course, index: true, foreign_key: true
  end
end
