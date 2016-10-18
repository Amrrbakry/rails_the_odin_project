class BookingsController < ApplicationController
  def new
  	@selected_flight = params[:selected_flight]
  end
end
