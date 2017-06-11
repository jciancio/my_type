class User < ActiveRecord::Base
  has_secure_password

  validates :email, uniqueness: true
  enum gender: [ :male, :female ]

  has_one :kairos_profile
  has_one :reaction_datum
  has_many :user_likes
  has_many :likes, through: :user_likes
  has_many :dislikes

  delegate :image_url, to: :kairos_profile
end
