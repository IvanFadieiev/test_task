class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :body
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :posts, [:user_id, :created_at]
    add_foreign_key :posts, :users
  end
end
