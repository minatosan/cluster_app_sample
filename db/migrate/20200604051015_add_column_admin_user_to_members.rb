class AddColumnAdminUserToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :admin_user, :boolean, default: false, null: false
  end
end
