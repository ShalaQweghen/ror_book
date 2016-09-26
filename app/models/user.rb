class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy
	has_many :comments, foreign_key: :commenter_id, dependent: :destroy

	validates :username, presence: true
	validates :email, presence: true
end
