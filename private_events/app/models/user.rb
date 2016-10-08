class User < ApplicationRecord
	has_many :events, foreign_key: "event_creator_id"
end
