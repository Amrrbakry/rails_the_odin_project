Airport.create(airport_code: "NYC")
Airport.create(airport_code: "LAX")
Airport.create(airport_code: "SFO")

Flight.create(start_airport_id: 1,
							finish_airport_id: 2,
							start: Date.today + 3.weeks,
							flight_duration: "4 hours")
Flight.create(start_airport_id: 1,
							finish_airport_id: 2,
							start: Date.today + 3.weeks,
							flight_duration: "5 hours")

Flight.create(start_airport_id: 2,
							finish_airport_id: 1,
							start: Date.today + 3.weeks,
							flight_duration: "4 hours")
Flight.create(start_airport_id: 1,
							finish_airport_id: 3,
							start: Date.today + 3.weeks,
							flight_duration: "4 hours")

Flight.create(start_airport_id: 1,
							finish_airport_id: 2,
							start: Date.today + 5.days,
							flight_duration: "7 hours")
Flight.create(start_airport_id: 1,
							finish_airport_id: 2,
							start: Date.today + 5.days,
							flight_duration: "7 hours")
Flight.create(start_airport_id: 1,
							finish_airport_id: 2,
							start: Date.today + 5.days,
							flight_duration: "7 hours")
Flight.create(start_airport_id: 2,
							finish_airport_id: 3,
							start: Date.today + 5.days,
							flight_duration: "7 hours")
Flight.create(start_airport_id: 3,
							finish_airport_id: 1,
							start: Date.today + 5.days,
							flight_duration: "7 hours")

Flight.create(start_airport_id: 3,
							finish_airport_id: 2,
							start: Date.today + 1.month,
							flight_duration: "6 hours")
Flight.create(start_airport_id: 2,
							finish_airport_id: 3,
							start: Date.today + 1.month,
							flight_duration: "6 hours")
Flight.create(start_airport_id: 2,
							finish_airport_id: 3,
							start: Date.today + 1.month,
							flight_duration: "6 hours")
Flight.create(start_airport_id: 2,
							finish_airport_id: 3,
							start: Date.today + 1.month,
							flight_duration: "6 hours")
Flight.create(start_airport_id: 1,
							finish_airport_id: 2,
							start: Date.today + 1.month,
							flight_duration: "6 hours")

Flight.create(start_airport_id: 2,
							finish_airport_id: 3,
							start: Date.today + 7.weeks,
							flight_duration: "2 hours")
Flight.create(start_airport_id: 1,
							finish_airport_id: 3,
							start: Date.today + 7.weeks,
							flight_duration: "2 hours")
Flight.create(start_airport_id: 3,
							finish_airport_id: 1,
							start: Date.today + 7.weeks,
							flight_duration: "2 hours")
Flight.create(start_airport_id: 3,
							finish_airport_id: 1,
							start: Date.today + 7.weeks,
							flight_duration: "2 hours")
Flight.create(start_airport_id: 3,
							finish_airport_id: 1,
							start: Date.today + 7.weeks,
							flight_duration: "2 hours")
Flight.create(start_airport_id: 3,
							finish_airport_id: 1,
							start: Date.today + 7.weeks,
							flight_duration: "2 hours")
Flight.create(start_airport_id: 2,
							finish_airport_id: 1,
							start: Date.today + 7.weeks,
							flight_duration: "2 hours")