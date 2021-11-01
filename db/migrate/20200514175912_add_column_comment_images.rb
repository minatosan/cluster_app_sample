class AddColumnCommentImages < ActiveRecord::Migration[5.2]
  def up
    add_column :comment_images, :introduction, :text
  end
end
