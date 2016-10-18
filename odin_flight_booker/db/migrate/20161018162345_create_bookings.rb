class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.integer :flight_id
      t.integer :passengers_num

      t.timestamps
    end
  end
end
