class Event < ApplicationRecord
	belongs_to :event_creator, class_name: "User"
  default_scope -> { order(created_at: :desc) } 
  has_many :attendees, through: :invites
  has_many :invites, foreign_key: "attended_event_id"

end
