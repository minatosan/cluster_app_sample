class RemoveToComments < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :comments, :users
    remove_reference :comments, :user, index: true
  end
end
