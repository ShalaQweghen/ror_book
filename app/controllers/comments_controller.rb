class CommentsController < ApplicationController

	def index
		@comments = Post.find(params[:id]).comments
	end

	def show
		@comment = Comment.find(params[:id])
	end

	def new
		@comment = Post.find(params[:post_id]).build
	end

	def create
		@comment = Post.find(params[:post_id]).build(comment_params)
		if @comment.save
			flash[:success] = "Comment successfully posted!"
			redirect_to post_path(params[:post_id])
		else
			flash.now[:error] = "Please check your info!"
			render post_path(params[:post_id])
		end
	end

	def edit
		@comment = Comment.find(params[:id])
	end

	def update
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
