class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.integer :status
      t.references :user, index: true, foreign_key: true
      t.references :department, index: true, foreign_key: true
      t.references :training, index: true, foreign_key: true
      t.references :course, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
