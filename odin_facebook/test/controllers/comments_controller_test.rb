require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

	def setup
		@user = users(:amr)
		@other_user = users(:ahmed)
		@post = posts(:one)
		@comment = comments(:one)
	end

	test "should redirect create when not logged in" do
		assert_no_difference 'Comment.count' do
			post comments_path, params: { comment: { content: "Lorem ipsum" } } 
		end
		assert_redirected_to sign_in_url
	end

	test "should redirect destroy when not logged in" do
		assert_no_difference 'Comment.count' do
			delete comment_path(@comment)
		end
		assert_redirected_to sign_in_url
	end

	test "should redirect destroy for wrong comment" do
		sign_in @other_user
		comment = comments(:one)
		assert_no_difference 'Comment.count' do
			delete comment_path(comment)
		end
		assert_redirected_to root_url
	end
end
