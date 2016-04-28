class AddZipToItineraries < ActiveRecord::Migration
  def change
  	add_column :itineraries, :zip, :integer
  end
end
