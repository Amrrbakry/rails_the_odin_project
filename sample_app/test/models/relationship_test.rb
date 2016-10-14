require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
	def setup 
		@relationship = Relationship.new(follower_id: users(:amr).id,
																		 followed_id: users(:archer).id)
	end

	test "relationship should be valid" do
		assert @relationship.valid?
	end

	test "follower_id should be present" do
		@relationship.follower_id = nil
		assert_not @relationship.valid?
	end

	test "followed_id should be present" do
		@relationship.followed_id = nil
		assert_not @relationship.valid?
	end

	test "should follow and unfollow a user" do
		amr = users(:amr)
		archer = users(:archer)
		assert_not amr.following?(archer)
		amr.follow(archer)
		assert amr.following?(archer)
		assert archer.followers.include?(amr)
		amr.unfollow(archer)
		assert_not amr.following?(archer)
	end

end
