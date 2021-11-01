class DropToCategoryName < ActiveRecord::Migration[5.2]
  def change
    remove_reference :categories, :category_name, index: true
    drop_table :category_names
  end
end
