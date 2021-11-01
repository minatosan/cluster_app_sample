class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.references :article, foreign_key: true
      t.references :group, foreign_key: true
      t.timestamps
    end
  end
end
