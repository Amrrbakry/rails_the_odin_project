class Passenger < ApplicationRecord
  has_many :bookings, through: :passenger_bookings
  has_many :passenger_bookings, dependent: :destroy
  has_many :flights,  through: :bookings
end
