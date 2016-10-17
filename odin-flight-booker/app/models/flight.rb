class Flight < ApplicationRecord
	belongs_to :start_airport, class_name: "Airport"
	belongs_to :finish_airport, class_name: "Airport"

	# returns array of arrays of all flight dates 
	def self.flight_dates
    all.collect { |f| [f.formatted_date, f.start.to_date] }.uniq
  end

  # formats the date Monday, 07 Nov 2016 12:00 AM
  def formatted_date
    start.strftime("%m/%d/%Y")
  end

  def self.search(params)
    if params[:search]
      Flight.on_date(params[:flight_date].to_date)
            .where(start_airport_id: params[:start_airport_id], finish_airport_id: params[:finish_airport_id])
            .includes(:start_airport, :finish_airport)
    end
  end
  
  def self.on_date(date)
    # elegant solution from: http://stackoverflow.com/questions/2381718/rails-activerecord-date-between
    where(start: date.beginning_of_day..date.end_of_day)
  end
end
