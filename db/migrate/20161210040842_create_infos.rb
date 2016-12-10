class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.string :content
      t.integer :status
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
