class UsersController < ApplicationController
    before_action :authenticate_user!
  def show
  	@user = User.find(params[:id])
  	@post = current_user.posts.build
  	@posts = @user.posts.all
  end

  def index
  	@users = User.all
  end

  def friends
    @friends = current_user.friends.all 
    render 'friends'
  end

  def notifications
    @pending_requests = current_user.pending_requests.all
    render 'notifications' 
  end
end
