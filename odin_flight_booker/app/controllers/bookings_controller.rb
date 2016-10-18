class BookingsController < ApplicationController
  def new
    @flight = Flight.find(params[:flight_id])
    @booking = @flight.bookings.build
    (params[:passengers_num].to_i - 1).times { @booking.passengers.build }
    @booking.passengers.build if params[:passengers].blank? #one passenger by default (user forgot to select)
  end

  def create 
  	@booking = Booking.new(booking_params)
  	if @booking.save
  		flash[:sucess] = "Flight booked successfully!"
			redirect_to booking_path(@booking)
		else
			flash.now[:danger] = "Error booking flight"
			render 'new'
		end 
  end

  def show
  	@booking = Booking.find(params[:id])
  end

  def booking_params
  	params.require(:booking).permit(:flight_id, 
  													 passengers_attributes: [:name, :email] )
  end
end
