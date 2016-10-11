class LikesController < ApplicationController
	before_action :authenticate_user!

	def create
		@like = Like.where(user_id: params[:like][:user_id], likable_id: params[:like][:likable_id])
		if @like.blank?
			@like = Like.new(like_params)
			if @like.save
				redirect_back(fallback_location: post_path(params[:like][:likable_id]))
			else
				redirect_to root_path
			end
		else
			@like.first.destroy
			redirect_back(fallback_location: post_path(params[:like][:likable_id]))
		end
	end

	private

	def like_params
		params.require(:like).permit(:user_id, :likable_id, :liked, :likable_type)
	end
end
