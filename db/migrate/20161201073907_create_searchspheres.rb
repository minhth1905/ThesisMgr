class CreateSearchspheres < ActiveRecord::Migration
  def change
    create_table :searchspheres do |t|
      t.string :name
      t.references :research, index: true, foreign_key: true
      t.references :sphere, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
