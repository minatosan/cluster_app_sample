class RemoveUserIdFromMember < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :members, :users
    remove_reference :members, :user, index: true
  end
end
