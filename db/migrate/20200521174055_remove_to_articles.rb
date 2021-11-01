class RemoveToArticles < ActiveRecord::Migration[5.2]
  def change
    remove_column(:articles,:lat, :decimal, precision: 7, scale: 5)
    remove_column(:articles,:lng, :decimal, precision: 8, scale: 5)
  end
end
