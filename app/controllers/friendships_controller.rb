class FriendshipsController < ApplicationController

  def new
    redirect_to user_path(params[:user_id], friend: true)
  end

  def create
  	@friending = current_user.friendings.build(friendship_params)
  	if @friending.save
      @friend = User.find(params[:friendship][:friend_id])
      @friendship = @friend.friendships.build(friendship_params)
      redirect_back(fallback_location: user_path(current_user.id))
    else
      redirect_to root_path
    end
  end

  def edit
    @friendship = Friendship.find(params[:id])
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.update_attributes(friendship_params)
    redirect_back(fallback_location: user_path(current_user.id))
  end

  def destroy
    Friendship.find(params[:id]).destroy
    redirect_back(fallback_location: user_path(current_user.id))
  end

  private

  def friendship_params
  	params.require(:friendship).permit(:friender_id, :friend_id, :approve)
  end
end
