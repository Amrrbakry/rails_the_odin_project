class Airport < ApplicationRecord
	has_many :departing_flight, foreign_key: :start_airport_id, class_name: "Flight"
	has_many :arriving_flights, foreign_key: :finish_airport_id, class_name: "Flight"
end
