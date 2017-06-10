class CreateUserLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :user_likes do |t|
      t.integer :like_id
      t.integer :user_id

      t.timestamps
    end
  end
end
