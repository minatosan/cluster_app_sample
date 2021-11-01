class RemoveToArticlesUser < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :articles, :users
    remove_reference :articles, :user, index: true
  end
end
