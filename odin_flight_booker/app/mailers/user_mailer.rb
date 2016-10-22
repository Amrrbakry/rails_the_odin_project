class UserMailer < ApplicationMailer
	# sends an email confirmaing the booking
	def confirm_booking(passenger, flight)
		@passenger = passenger
		@flight = flight
		@url = 'https://shrouded-earth-72460.herokuapp.com'
		mail(to: @passenger.email, subject: "Booking Confirmed!")
	end
end
