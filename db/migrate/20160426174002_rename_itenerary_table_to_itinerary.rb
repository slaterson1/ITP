class RenameIteneraryTableToItinerary < ActiveRecord::Migration
  def change
  	rename_table :iteneraries, :itineraries
  end
end
