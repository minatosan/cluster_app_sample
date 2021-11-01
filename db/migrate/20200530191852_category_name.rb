class CategoryName < ActiveRecord::Migration[5.2]
  def change
    create_table :category_names do |t|
      t.string :name
      t.timestamps
    end
  end
end
