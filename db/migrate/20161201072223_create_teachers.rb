class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.text :description
      t.string :code
      t.references :user, index: true, foreign_key: true
      t.references :department, index: true, foreign_key: true
      t.references :subject, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
