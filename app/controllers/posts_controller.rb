class PostsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_post, only: [:show, :edit, :update, :destroy]

	def index
	end

	def show
		if params[:edit]
			@comment = Comment.find(params[:comment_id])
		else
			@comment = Comment.new
		end
	end

	def new
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			flash[:success] = "Post successfully created!"
			redirect_to @post
		else
			flash.now[:error] = "Please check your info!"
			render :new
		end
	end

	def edit
	end

	def update
		if @post.update_attributes(post_params)
			flash[:success] = "Post successfully updated!"
			redirect_to @post
		else
			flash.now[:error] = "Please check your info!"
			render :edit
		end
	end

	def destroy
		@post.destroy
		
		flash[:success] = "Post successfully deleted!"
		redirect_back(fallback_location: posts_path)
	end

	private

	def post_params
		params.require(:post).permit(:body, :picture, :remove_picture)
	end

	def set_post
		@post = Post.find(params[:id])
	end
end
