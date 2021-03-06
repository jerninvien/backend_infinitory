class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.timestamp :start_time, null: false
      t.timestamp :end_time, null: false
      t.references :user, foreign_key: true
      t.references :device, foreign_key: true

      t.timestamps
    end
  end
end
