class LikesController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_user, only: [:destroy]

  def index
    @post = Post.find_by(id: params[:post_id])
    @likes = @post.likes.all
  end

  def create
  	@post = Post.find_by(id: params[:post_id])
  	@like = @post.likes.build(user_id: current_user.id)
  	if @like.save
  		redirect_back(fallback_location: root_url)
  	else
  		flash[:danger] = "Error liking post"
  		redirect_back(fallback_location: root_url)
  	end
  end

  def destroy
  	@like.destroy
  	redirect_back(fallback_location: root_url)
  end

  private

  	def correct_user
			@like = current_user.likes.find_by(id: params[:id])
			redirect_to root_url if @like.nil?
		end
end
