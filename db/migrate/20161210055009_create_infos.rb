class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.text :content
      t.integer :status
      t.integer :user_send
      t.integer :user_receive

      t.timestamps null: false
    end
    add_index :infos, :user_send
    add_index :infos, :user_receive
    # add_index :infos, [:user_send, :user_receive], unique: true
  end
end
