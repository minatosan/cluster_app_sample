class AddIntroductionToArticleImages < ActiveRecord::Migration[5.2]
  def change
    add_column :article_images, :introduction, :string
  end
end
