class AddReferencesProfilesToGroups < ActiveRecord::Migration[5.2]
  def change
    add_reference :groups, :admin_user, foreign_key:  { to_table: :profiles }
  end
end
