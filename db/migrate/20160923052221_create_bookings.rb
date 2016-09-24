class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.string :conference_room_id
      t.string :status
      t.datetime :start_time
      t.datetime :end_time
    end
  end
end
