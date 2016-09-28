class CommentsController < ApplicationController
	before_action :authenticate_user!

	def new
		redirect_to post_path(params[:post_id], comment: true)
	end

	def create
		@comment = Post.find(params[:comment][:post_id]).comments.build(comment_params)
		if @comment.save
			flash[:success] = "Comment successfully posted!"
			redirect_to post_path(params[:comment][:post_id])
		else
			flash[:error] = "Please check your info!"
			render post_path(params[:comment][:post_id])
		end
	end

	def edit
		redirect_to post_path(params[:post_id], comment: true, edit: true)
	end

	def update
		@comment = Comment.find(params[:id])
		if @comment.update_attributes(comment_params)
			flash[:success] = "Comment successfully edit!"
			redirect_to post_path(params[:post_id])
		else
			flash.now[:error] = "Please check your info!"
			render post_url(params[:post_id])
		end
	end

	def destroy
		Comment.find(params[:id]).destroy
		flash[:success] = "Comment successfully deleted!"
		redirect_to post_path(params[:post_id])
	end

	private

	def comment_params
		params.require(:comment).permit(:body, :commenter_id, :post_id)
	end
end
