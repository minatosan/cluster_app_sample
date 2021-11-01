class RenameColumnFriends < ActiveRecord::Migration[5.2]
  def change
    remove_reference :friends, :from_user_id, foreign_key:  { to_table: :profiles }
    remove_reference :friends, :to_user_id, foreign_key:  { to_table: :profiles }
    add_reference :friends, :from_user, foreign_key:  { to_table: :profiles }
    add_reference :friends, :to_user, foreign_key:  { to_table: :profiles }
  end
end
