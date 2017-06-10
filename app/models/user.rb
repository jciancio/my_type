class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  before_save -> { skip_confirmation! }

  validates :email, uniqueness: true
  enum gender: [ :male, :female ]

  has_one :kairos_profile
  has_one :reaction_datum
  has_many :user_likes
  has_many :likes, through: :user_likes

end
