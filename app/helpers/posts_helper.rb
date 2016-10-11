module PostsHelper

	def friend_ids
  	current_user.friendships.map { |f| f.friender_id } + current_user.friendings.map { |f| f.friend_id } << current_user.id
  end

	def posts
		id_list = friend_ids
		posts = Post.all.order(created_at: :desc).select { |p| id_list.include?(p.user_id) }
		posts += Picture.all.order(created_at: :desc).select { |p| id_list.include?(p.user_id) }
		posts.sort! { |a, b| b.created_at <=> a.created_at }
	end
end
