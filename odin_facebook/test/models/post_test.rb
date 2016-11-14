require 'test_helper'

class PostTest < ActiveSupport::TestCase
	def setup
		@user = users(:amr)
		@post = @user.posts.build(content: "Lorem")
	end

	test "should be valid" do
		assert @post.valid?
	end

	test "content should be present" do
		@post.content = ""
		assert_not @post.valid?
	end

	test "user_id should be present" do
		@post.user_id = nil
		assert_not @post.valid?
	end
end
