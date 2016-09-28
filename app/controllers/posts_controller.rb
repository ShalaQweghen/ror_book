class PostsController < ApplicationController
	before_action :authenticate_user!

	def index
		@posts = Post.all
	end

	def show
		@post = Post.find(params[:id])
		if params[:edit]
			@comment = Comment.find(params[:id])
		else
			@comment = @post.comments.build
		end
	end

	def new
		@post = User.find(params[:id]).posts.build
	end

	def create
		@post = User.find(params[:post][:id]).posts.build(post_params)
		if @post.save
			flash[:success] = "Post successfully created!"
			redirect_to @post
		else
			flash.now[:error] = "Please check your info!"
			render :new
		end
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		if @post.update_attributes(post_params)
			flash[:success] = "Post successfully updated!"
			redirect_to @post
		else
			flash.now[:error] = "Please check your info!"
			render :edit
		end
	end

	def destroy
		Post.find(params[:id]).destroy
		flash[:success] = "Post successfully deleted!"
		redirect_to posts_path
	end

	private

	def post_params
		params.require(:post).permit(:body, :user_id)
	end
end
