require 'test_helper'

class PostTest < ActiveSupport::TestCase
	
	def setup
		@post = Post.new(title: "Example Post", body: "This is an example post.", user_id: 1)
	end

	test "title should be present" do
		@post.title = ""
		assert_not @post.valid?
	end

	test "body should be present" do
		@post.body = "   "
		assert_not @post.valid?
	end

	test "user_id should be present" do
		@post.user_id = nil
		assert_not @post.valid?
	end

	test "title should not be too long" do
		@post.title = "a" * 251
		assert_not @post.valid?
	end

	test "body should not be too long" do 
		@post.body = "a" * 701
		assert_not @post.valid?
	end
end
