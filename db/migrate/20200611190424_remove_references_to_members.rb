class RemoveReferencesToMembers < ActiveRecord::Migration[5.2]
  def change
    remove_column :members, :admin_user, :boolean
  end
end
