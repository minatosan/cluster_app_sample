class AddTableFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.integer :from_user_id
      t.integer :to_user_id
      t.boolean :request
      t.timestamps
    end
    add_index :friends, :from_user_id
    add_index :friends, :to_user_id
    add_index :friends, [:from_user_id, :to_user_id], unique: true
  end
end
