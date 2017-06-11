class CreateDislikes < ActiveRecord::Migration[5.1]
  def change
    create_table :dislikes do |t|
      t.integer :dislike_id
      t.integer :user_id

      t.timestamps
    end
  end
end
