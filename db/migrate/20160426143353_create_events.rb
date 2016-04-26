class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :team
      t.string :gps_location
      t.string :city
      t.string :state
      t.integer :zip
      t.string :street_address
      t.decimal :low_price
      t.decimal :high_price
      t.decimal :average_price
      t.string :venue_photo
      t.string :ticket_url
      t.datetime :local_datetime

      t.timestamps null: false
    end
  end
end
