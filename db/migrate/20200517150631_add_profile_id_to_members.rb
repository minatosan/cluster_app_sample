class AddProfileIdToMembers < ActiveRecord::Migration[5.2]
  def change
    add_reference :members, :profile, foreign_key: true
  end
end
