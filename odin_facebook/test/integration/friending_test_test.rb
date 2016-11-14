require 'test_helper'

class FriendingTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers


  def setup
    @user  = users(:amr)
    @other = users(:ahmed)
    sign_in @user
  end

  test "should friend a user the standard way" do
    assert_difference '@user.friends.count', 1 do
      @other.friend(@user)
      accept_friend_request(@user, @other)
    end
  end

  test "should not be friends if friend request not accepted" do
    assert_no_difference '@user.friends.count' do
      @other.friend(@user)
    end

    assert_no_difference '@other.friends.count' do
      @other.friend(@user)
    end
  end

  test "should have a friend request" do
    assert_difference '@other.friend_requests.count', 1 do
      @other.friend(@user)
    end
  end

  test "should have a pending_request" do
    assert_difference '@user.pending_requests.count', 1 do
      @other.friend(@user)
    end
  end

  test "should unfriend a user they friended the standard way" do
    @other.friend(@user)
    accept_friend_request(@user, @other)
    friendship = @user.friendships.find_by(friend_id: @other.id)
    assert_difference '@user.friends.count', -1 do
      delete friendship_path(friendship)
    end
  end

  test "should unfriend a user they friended with Ajax" do
    @other.friend(@user)
    accept_friend_request(@user, @other)
    friendship = @user.friendships.find_by(friend_id: @other.id)
    assert_difference '@user.friends.count', -1 do
      delete friendship_path(friendship), xhr: true
    end
  end

  test "should unfriend a user that friended them the standard way" do
    @other.friend(@user)
    accept_friend_request(@user, @other)
    friendship = @other.inverse_friendships.find_by(user_id: @user.id)
    assert_difference '@user.friends.count', -1 do
      delete friendship_path(friendship)
    end
  end

  test "should unfriend a user that friended them with Ajax" do
    @other.friend(@user)
    accept_friend_request(@user, @other)
    friendship = @other.inverse_friendships.find_by(user_id: @user.id)
    assert_difference '@user.friends.count', -1 do
      delete friendship_path(friendship), xhr: true
    end
  end

end