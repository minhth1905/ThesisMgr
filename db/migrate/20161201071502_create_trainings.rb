class CreateTrainings < ActiveRecord::Migration
  def change
    create_table :trainings do |t|
      t.string :name
      t.text :description
      t.timestamps null: false
    end
  end
end
