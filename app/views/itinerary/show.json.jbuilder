json.itineraries @itineraries do |itinerary|
	json.start_date itinerary.start_date
	json.user_id itinerary.user_id
	json.zip itinerary.zip

	json.pitstops @pitstops do |pitstop|
		json.itinerary_id pitstop.itinerary_id
		json.date_visited pitstop.date_visited
		json.stop_number pitstop.stop_number
		json.zip pitstop.zip		
	end	
end			