class Post < ApplicationRecord
	belongs_to :user
	has_many :likes, as: :likable, dependent: :destroy
	has_many :comments, as: :commentable, dependent: :destroy

	mount_uploader :picture, ::PictureUploader

	validates :body, presence: true
end
