class Friendship < ApplicationRecord
	belongs_to :friender, class_name: "User", primary_key: :id
	belongs_to :friend, class_name: "User", primary_key: :id
end