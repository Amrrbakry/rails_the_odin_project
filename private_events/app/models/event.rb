class Event < ApplicationRecord
	belongs_to :event_creator, class_name: "User"
  default_scope -> { order(created_at: :desc) } 

end
