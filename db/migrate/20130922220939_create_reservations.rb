class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :party_size
      t.belongs_to :user
      t.belongs_to :restaurant
      t.time :meal_time
      t.date :day

      t.timestamps
    end
  end
end
