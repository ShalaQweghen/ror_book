class Comment < ApplicationRecord
	belongs_to :post
	belongs_to :commenter, class_name: "User"

	validates :body, presence: true
	validates :commenter_id, presence: true
	validates :post_id, presence: true
end
