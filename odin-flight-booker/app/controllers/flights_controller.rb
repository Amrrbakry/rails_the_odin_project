class FlightsController < ApplicationController

def index
	@airports_array = Airport.all.map { |airport| [airport.airport_code, airport.id] }
	@passengers_num = (1..4).collect { |num| [num, num] }
	@flight_dates = Flight.flight_dates
	@flights = Flight.search(params)
end

def new 
	@flight = Flight.new
end

end
