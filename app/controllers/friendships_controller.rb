class FriendshipsController < ApplicationController
  
  def destroy
    @friendship = current_user.friendships.where(friend_id: params[:id]).first
    @friendship.destroy
    flash[:notice] = "Friend was successfully removed"
  end
  
end