class AddToCommentsReferences < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :profile, foreign_key: true
  end
end
