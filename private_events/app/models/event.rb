class Event < ApplicationRecord
	belongs_to :event_creator, class_name: "User"
  default_scope -> { order(created_at: :desc) } 
  has_many :attendees, through: :invites
  has_many :invites, foreign_key: "attended_event_id"

	validate :event_date_cannot_be_in_the_past

	scope :upcoming, -> { where("date > ?", Date.today) }
	scope :past, -> { where("date < ?", Date.today) }


	 def event_date_cannot_be_in_the_past
    	errors.add(:date, "can't be in the past") if !date.blank? and date < Date.today
   end
end
