class AddToUserIdToFriends < ActiveRecord::Migration[5.2]
  def change
    remove_column :friends, :from_user_id, :integer
    remove_column :friends, :to_user_id, :integer
    add_reference :friends, :from_user_id, foreign_key:  { to_table: :profiles }
    add_reference :friends, :to_user_id, foreign_key:  { to_table: :profiles }
  end
end
