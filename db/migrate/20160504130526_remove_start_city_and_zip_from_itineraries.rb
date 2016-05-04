class RemoveStartCityAndZipFromItineraries < ActiveRecord::Migration
  def change
  	remove_column :itineraries, :start_city, :string
  	remove_column :itineraries, :zip, :integer
  end
end
