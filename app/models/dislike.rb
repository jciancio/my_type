class Dislike < ApplicationRecord
  belongs_to :user
  belongs_to :dislike, class_name: 'User'

  validates :user_id, uniqueness: { scope: :dislike_id }
end
