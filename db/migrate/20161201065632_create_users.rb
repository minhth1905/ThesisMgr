class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :rules
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.string :genner
      t.string :country
      t.string :province
      t.string :distric
      t.string :town

      t.timestamps null: false
    end
  end
end
