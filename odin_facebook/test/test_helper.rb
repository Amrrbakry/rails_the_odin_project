ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def accept_friend_request(user, friend)
    pending_request = user.pending_requests.find_by(friend_id: friend.id)
    friend_request = friend.friend_requests.find_by(friend_id: user.id)
    pending_request.update_attribute(:status, "accepted") && friend_request.update_attribute(:status, "accepted")
  end
end
