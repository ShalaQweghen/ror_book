class User < ApplicationRecord
	has_many :posts, dependent: :destroy
	has_many :comments, foreign_key: :commenter_id, dependent: :destroy

	validates :username, presence: true
	validates :email, presence: true
end
