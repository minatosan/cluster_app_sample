class RemoveGroupIdFromArticles < ActiveRecord::Migration[5.2]
  def change
    remove_reference :articles, :group, foreign_key: true
  end
end
