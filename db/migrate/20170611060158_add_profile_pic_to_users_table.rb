class AddProfilePicToUsersTable < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :image_link, :string, default: nil
  end
end
