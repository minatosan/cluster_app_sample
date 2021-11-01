class RemoveCategoryToName < ActiveRecord::Migration[5.2]
  def change
    remove_column :categories,:name,:string
    add_reference :categories, :category_name, foreign_key: true
  end
end
