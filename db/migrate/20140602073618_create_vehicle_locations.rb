class CreateVehicleLocations < ActiveRecord::Migration
  def change
    create_table :vehicle_locations do |t|
      t.integer :user_id
      t.integer :latitude
      t.integer :longitude

      t.timestamps
    end
  end
end
