class AddValuesToReactionData < ActiveRecord::Migration[5.1]
  def change
    add_column :reaction_data, :anger, :float
    add_column :reaction_data, :disgust, :float
    add_column :reaction_data, :fear, :float
    add_column :reaction_data, :joy, :float
    add_column :reaction_data, :sadness, :float
    add_column :reaction_data, :surprise, :float
  end
end
