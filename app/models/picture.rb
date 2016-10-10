class Picture < ApplicationRecord
	has_many :comments, as: :commentable, dependent: :destroy
	has_many :likes, as: :likable, dependent: :destroy
	belongs_to :user

	mount_uploader :picture, ::PictureUploader

	validates :picture, presence: true
end
