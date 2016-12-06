class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.text :content
      t.integer :status

      t.timestamps null: false
    end
  end
end
