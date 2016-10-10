module UsersHelper

	def all_posts(id)
		user = User.find(id)
		posts = user.posts + user.pictures
	end

	def picture?(post)
		post.class == Picture
	end

	def body_or_picture(post)
		if picture?(post)
			post.picture
		else
			post.body[0..250] + "..."
		end
	end

	def path(post)
		if picture?(post)
			picture_path(post)
		else
			post_path(post)
		end
	end

	def edit_path(post)
		if picture?(post)
			edit_picture_path(post)
		else
			edit_post_path(post)
		end
	end

	def find_friend
		Friendship.find_by(friender_id: current_user.id, friend_id: params[:id]) || Friendship.find_by(friender_id: params[:id], friend_id: current_user.id)
	end

	def not_friend?(user)
		current_user.id != user.id && Friendship.all.none? { |f| [current_user.id, user.id].include?(f.friender_id) && [current_user.id, user.id].include?(f.friend_id) }
	end

	def friends(user)
		user.friendships.where(approve: 1).map(&:friender) + user.friendings.where(approve: 1).map(&:friend)
	end
end
