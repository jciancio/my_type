class CreateReactionData < ActiveRecord::Migration[5.1]
  def change
    create_table :reaction_data do |t|
      t.belongs_to :user_like, foreign_key: true

      t.timestamps
    end
  end
end
