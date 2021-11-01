class AddIndexToMember < ActiveRecord::Migration[5.2]
  def change
    add_index :members, [:group_id, :profile_id], :unique => true
  end
end
