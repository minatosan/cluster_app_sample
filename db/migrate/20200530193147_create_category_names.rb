class CreateCategoryNames < ActiveRecord::Migration[5.2]
  def change
      add_column :category_names,:text,:text
  end
end
