class CreateKairosProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :kairos_profiles do |t|
      t.string :eye_distance

      t.timestamps
    end
  end
end
