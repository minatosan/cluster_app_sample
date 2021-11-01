class AddArticles < ActiveRecord::Migration[5.2]
  def change
    add_column(:articles,:lat, :decimal, precision: 7, scale: 5)
    add_column(:articles,:lng, :decimal, precision: 8, scale: 5)
  end
end
