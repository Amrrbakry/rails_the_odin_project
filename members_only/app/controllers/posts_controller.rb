class PostsController < ApplicationController

	before_action :logged_in_user, only: [:new, :create]

  def new
  	@post = Post.new
  end

  def create
  	@post = current_user.posts.create(user_params)
  	if @post.save
  		flash[:success] = "Post created successfully!"
  		redirect_to root_url
  	else
  		flash.now[:danger] = "There was a problem creating the post. Please try again."
  		render 'new'
  	end
  end

  def index
  	@posts = Post.all
  end

  private

	  def user_params
	  	params.require(:post).permit(:title, :body)
	  end

	  # before filter

    # confirms a logged-in user
    def logged_in_user
      unless logged_in?
        flash.now[:danger] = "Please log in"
        redirect_to login_url
      end
    end

end
