json.itinerary @itinerary, :id, :start_date, :travel_days, :user_id, :zip
json.pitstops @itinerary.pitstops do |pitstop|
		json.(pitstop, :id, :itinerary_id, :date_visited, :stop_number, :zip)
end	
