class CreateResearches < ActiveRecord::Migration
  def change
    create_table :researches do |t|
      t.string :name
      t.text :description
      t.references :teacher, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
