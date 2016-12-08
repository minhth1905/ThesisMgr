class AddNewNameToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :new_name, :string
  end
end
