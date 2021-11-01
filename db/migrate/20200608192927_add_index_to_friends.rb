class AddIndexToFriends < ActiveRecord::Migration[5.2]
  def change
    change_column :friends, :request, :boolean, default: false
  end
end
