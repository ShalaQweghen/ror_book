module PostsHelper

	def posts
		list = current_user.friendships.map { |f| f.friender_id if f.approve == 1} + current_user.friendings.map { |f| f.friend_id if f.approve == 1} << current_user.id
		posts = Post.all.order(created_at: :desc).select { |p| list.include?(p.user_id) }
		posts += Picture.all.order(created_at: :desc).select { |p| list.include?(p.user_id) }
		posts.sort! { |a, b| b.created_at <=> a.created_at }
	end
end
