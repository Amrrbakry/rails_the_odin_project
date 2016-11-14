require 'test_helper'

class LikeTest < ActiveSupport::TestCase
	def setup 
		@user = users(:amr)
		@post = @user.posts.create(content: "post")
		@like = @user.posts.find_by(id: @post.id).likes.build(user_id: @user.id)
	end

	test "should be valid" do
		assert @like.valid?
	end

	test "user_id should be present" do
		@like.user_id = nil
		assert_not @like.valid?
	end

	test "post_id should be present" do
		@like.post_id = nil
		assert_not @like.valid?
	end
end
