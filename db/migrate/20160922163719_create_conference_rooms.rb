class CreateConferenceRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :conference_rooms do |t|
      t.string :name

      t.timestamps
    end
  end
end
