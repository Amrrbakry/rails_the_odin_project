class CommentsController < ApplicationController
	 before_action :authenticate_user!
	 before_action :correct_user, only: [:destroy]

	def new
		@comment = current_user.posts.find(params[:id]).comments.build
	end

	def create
		current_post = Post.find(params[:post_id])
		@comment = current_post.comments.build(comment_params)
		if @comment.save
			redirect_back(fallback_location: root_url)
		else
			flash[:error] = "Error posting comment! comment cannot be empty."
			redirect_back(fallback_location: root_url)
		end
	end

	def destroy
		@comment.destroy
		redirect_back(fallback_location: root_url)
	end

	private

		def comment_params
			params.require(:comment).permit(:content, :comment_picture).merge(user_id: current_user.id)
		end

		def correct_user
			@comment = current_user.comments.find_by(id: params[:id])
			redirect_to root_url if @comment.nil?
		end

end
