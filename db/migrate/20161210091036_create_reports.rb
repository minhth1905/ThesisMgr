class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.float :count
      t.text :opinion_teacher
      t.text :opinion_depart
      t.references :topic, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
