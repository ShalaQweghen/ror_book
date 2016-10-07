class CommentsController < ApplicationController
	before_action :authenticate_user!

	def create
		@comment = Comment.new(comment_params)
		if @comment.save
			flash[:success] = "Comment successfully posted!"
			redirect_back(fallback_location: post_path(params[:comment][:commentable_id]))
		else
			flash[:error] = "Please check your info!"
			render post_path(params[:comment][:commentable_id])
		end
	end

	def edit
		redirect_to post_path(params[:commentable_id], edit: true, comment_id: params[:id])
	end

	def update
		@comment = Comment.find(params[:id])
		if @comment.update_attributes(comment_params)
			flash[:success] = "Comment successfully edit!"
			redirect_to post_path(params[:comment][:commentable_id])
		else
			flash.now[:error] = "Please check your info!"
			render post_url(params[:comment][:commentable_id])
		end
	end

	def destroy
		Comment.find(params[:id]).destroy
		flash[:success] = "Comment successfully deleted!"
		redirect_back(fallback_location: post_path(params[:commentable_id]))
	end

	private

	def comment_params
		params.require(:comment).permit(:body, :commenter_id, :commentable_id, :commentable_type)
	end
end
