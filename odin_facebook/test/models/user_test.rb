require 'test_helper'

class UserTest < ActiveSupport::TestCase
	include Devise::Test::IntegrationHelpers
	
	def setup
		@user = users(:amr)
   	@other = users(:ahmed)
   	@sam = users(:sam)
   	sign_in @user
	end

  test "feed should have the right posts" do
  	@sam.friend(@user)
  	accept_friend_request(@user, @sam)
    
    # Posts from friend
    @sam.posts.each do |post_following|
      assert @user.feed.include?(post_following)
    end
    # Posts from sels
    @user.posts.each do |post_self|
      assert @user.feed.include?(post_self)
    end
    # Posts from a user that is not a friend
    @other.posts.each do |post_unfollowed|
      assert_not @user.feed.include?(post_unfollowed)
    end
  end
end
