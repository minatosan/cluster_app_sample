class AddReferencesToArticles < ActiveRecord::Migration[5.2]
  def change
    add_reference :articles, :group, foreign_key: true
  end
end
