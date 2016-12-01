class CreateSpheres < ActiveRecord::Migration
  def change
    create_table :spheres do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
