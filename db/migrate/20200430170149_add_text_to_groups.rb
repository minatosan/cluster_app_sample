class AddTextToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :text, :text
  end
end
