class FriendshipsController < ApplicationController

  def new
  	@user = User.find(params[:user_id])
  	@friendship = @user.friendships.build
  end

  def create
  	@user = User.find(params[:user_id])
  	@friendship = @user.friendships.build(friendship_params)
  	if @friendship.save

  	else

  	end
  end

  def edit
    @friendship = Friendship.find(params[:id])
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.update_attributes(friendship_params)
  end

  def delete
    Friendship.find(params[:id]).destroy
  end

  private

  def friendship_params
  	params.require(:friendship).permit(:user_id, :friend_id, :save)
  end
end
