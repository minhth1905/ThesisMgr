class AddIsProtecedToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :is_proteced, :integer
  end
end
