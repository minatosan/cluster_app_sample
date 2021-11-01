class AddToArticlesProfile < ActiveRecord::Migration[5.2]
  def change
    add_reference :articles, :profile, foreign_key: true
  end
end
