class StaticPagesController < ApplicationController
	before_filter :authenticate_user!
	def home
		@post = current_user.posts.build
		@feed = current_user.feed
	end
end
