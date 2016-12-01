class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :job_title
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
