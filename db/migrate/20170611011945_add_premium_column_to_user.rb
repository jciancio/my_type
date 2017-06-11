class AddPremiumColumnToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :premium, :boolean, default: false
  end
end
