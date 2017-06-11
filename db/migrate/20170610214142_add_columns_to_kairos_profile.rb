class AddColumnsToKairosProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :kairos_profiles, :chin_to_eye_height, :float
    add_column :kairos_profiles, :eye_width, :float
    remove_column :kairos_profiles, :eye_distance, :float
    add_column :kairos_profiles, :face_proportion, :float
    add_column :kairos_profiles, :hispanic, :float
    add_column :kairos_profiles, :asian, :float
    add_column :kairos_profiles, :other, :float
    add_column :kairos_profiles, :white, :float
    add_column :kairos_profiles, :black, :float
    add_column :kairos_profiles, :image_url, :string
    add_column :kairos_profiles, :user_id, :integer
  end
end
