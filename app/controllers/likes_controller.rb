class LikesController < ApplicationController

	def create
		@like = Like.where(user_id: params[:like][:user_id], post_id: params[:like][:post_id])
		if @like.blank?
			@like = Like.new(like_params)
			if @like.save
				redirect_back(fallback_location: post_path(params[:like][:post_id]))
			else
				redirect_to root_path
			end
		else
			@like.first.destroy
			redirect_back(fallback_location: post_path(params[:like][:post_id]))
		end
	end

	private

	def like_params
		params.require(:like).permit(:user_id, :post_id, :liked)
	end
end
