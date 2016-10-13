class PicturesController < ApplicationController
	before_action :authenticate_user!

	def show
		@posting = Picture.find(params[:id])
		if params[:edit]
			@comment = Comment.find(params[:comment_id])
		else
			@comment = Comment.new
		end
	end

	def new
		@picture = current_user.pictures.build
	end

	def create
		@picture = current_user.pictures.build(picture_params)
		if @picture.save
			flash[:success] = "Post successfully created!"
			redirect_to @picture
		else
			flash.now[:error] = "Please check your info!"
			render :new
		end
	end

	def edit
		@picture = Picture.find(params[:id])
	end

	def update
		@picture = Picture.find(params[:id])
		if @picture.update_attributes(picture_params)
			flash[:success] = "Picture successfully updated!"
			redirect_to @picture
		else
			flash.now[:error] = "Please check your info!"
			render :edit
		end
	end

	def destroy
		Picture.find(params[:id]).destroy
		flash[:success] = "Picture successfully deleted!"
		redirect_to pictures_path
	end

	private

	def picture_params
		params.require(:picture).permit(:picture)
	end
end
