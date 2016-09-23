class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "Profile successfully created!"
			redirect_to @user
		else
			flash.now[:error] =  "Please check your info"
			render :new
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		if @user.update_attributes(user_params)
			flash[:success] = "Profile successfully updated!"
			redirect_to @user
		else
			flash[:error] = "Please check your info!"
			render :edit
		end
	end

	def destroy
		User.find_by(params[:id]).destroy
		flash[:success] = "User successfully deleted!"
		redirect_to users_path
	end

	private

	def user_params
		params.require(:user).permit(:username, :email)
	end
end
