class CreateTimenotifis < ActiveRecord::Migration
  def change
    create_table :timenotifis do |t|
      t.datetime :time_start
      t.datetime :time_end
      t.integer :status

      t.timestamps null: false
    end
  end
end
