require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers
	
	def setup
		@user = users(:amr)
		@post = posts(:one)
	end

	test "should redirect create when not logged in" do
		assert_no_difference 'Post.count' do
			post posts_path, params: { post: { content: "Lorem ipsum" } } 
		end
		assert_redirected_to sign_in_url
	end

	test "should redirect destroy when not logged in" do
		assert_no_difference 'Post.count' do
			delete post_path(@post)
		end
		assert_redirected_to sign_in_url
	end

	test "should redirect destroy for wrong post" do
		sign_in @user 
		post = posts(:three)
		assert_no_difference 'Post.count' do
			delete post_path(post)
		end
		assert_redirected_to root_url
	end
end
