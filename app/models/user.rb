class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy
  has_many :friendships, dependent: :destroy, foreign_key: :friend_id
  has_many :friendings, dependent: :destroy, class_name: "Friendship", foreign_key: :friender_id
  has_many :friends, through: :friendships
  has_many :frienders, through: :friendships
	has_many :comments, foreign_key: :commenter_id, dependent: :destroy

	validates :username, presence: true
	validates :email, presence: true
end
