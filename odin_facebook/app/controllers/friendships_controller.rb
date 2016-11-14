class FriendshipsController < ApplicationController
	before_action :authenticate_user!

  def create
    @user = User.find(params[:friend_id])
    current_user.friend(@user)
    respond_to do |format|
      format.html { redirect_to @user }
    end
  end

  def update
    @user = User.find(params[:friend_id])
    @pending_request = current_user.pending_requests.find_by(friend_id: @user)
    @friend_request = @user.friend_requests.find_by(friend_id: current_user.id)
    if @pending_request.update_attribute(:status, "accepted") && @friend_request.update_attribute(:status, "accepted")
      flash[:sucss] = "You're now friends with " + @user.username
      redirect_to @user
    else
      flash.now[:error] = "Error accepting friend request"
    end
  end

  def destroy
    @user = Friendship.find(params[:id]).friend 
    if @user == current_user
      @user = Friendship.find(params[:id]).user
    end
    current_user.unfriend(@user) 
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js { redirect_to @user }
    end
  end

end
