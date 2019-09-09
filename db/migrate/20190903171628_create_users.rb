class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :vechile_id
      t.integer :package_id
      t.integer :travel_type_id
      t.integer :from_area_id
      t.integer :to_area_id
      t.integer :to_city_id
      t.string :online_booking
      t.string :mobile_site_booking
      t.integer :booking_created
      t.integer :from_lat
      t.integer :from_long
      t.integer :to_let
      t.integer :to_long
      t.string :car_cancellation 
      
      t.timestamps
    end
  end
end
