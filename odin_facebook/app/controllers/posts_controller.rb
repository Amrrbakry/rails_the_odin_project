class PostsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :destroy]
	before_action :correct_user,  		 only: [:destroy, :edit]
	
	def new
		@post = current_user.posts.new
	end

	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			flash[:sucess] = "Post created successfully"
			redirect_to @post
		else
			render 'new'
		end
	end

	def show
		@post = Post.find(params[:id])
		@like = @post.likes.build(user_id: current_user.id)
		@unlike = @post.likes.find_by(user_id: current_user.id)
		@likes = @post.likes.all
		@comment = @post.comments.build
		@comments = @post.comments.all
	end


  def edit 
  	@post = Post.find(params[:id])
  end

  def update
  	@post = Post.find(params[:id])
  	if @post.update_attributes(post_params)
  		flash[:sucess] = "Post updated!"
  		redirect_to @post
  	else
  		render 'edit'
  	end
  end

	def destroy
		@post.destroy
		flash[:sucess] = "Post deleted!"
		redirect_to current_user
	end

	private

		def post_params
			params.require(:post).permit(:content, :picture)
		end

		def correct_user
			@post = current_user.posts.find_by(id: params[:id])
			redirect_to root_url if @post.nil?
		end
end
