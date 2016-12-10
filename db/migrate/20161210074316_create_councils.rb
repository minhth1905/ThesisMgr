class CreateCouncils < ActiveRecord::Migration
  def change
    create_table :councils do |t|
      t.integer :chairman
      t.integer :commissioner
      t.integer :secretary
      t.string :name

      t.timestamps null: false
    end
  end
end
