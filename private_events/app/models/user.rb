class User < ApplicationRecord
	has_many :events, foreign_key: "event_creator_id"
	has_many :invites, foreign_key: "attendee_id"
	has_many :attended_events, through: :invites
end
