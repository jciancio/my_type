class UserLike < ApplicationRecord
  belongs_to :user
  belongs_to :like, class_name: 'User'
  has_one :reaction_datum

  validates :user_id, uniqueness: { scope: :like_id }
end
