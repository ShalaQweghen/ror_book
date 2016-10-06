class Post < ApplicationRecord
	belongs_to :user
	has_many :likes
	has_many :comments, dependent: :destroy

	mount_uploader :picture, ::PictureUploader

	validates :body, presence: true
	validates :user_id, presence: true
end
