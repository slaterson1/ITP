json.itinerary @itinerary, :id, :start_date
json.pitstops @itinerary.pitstops do |pitstop|
		json.(pitstop, :id, :date_visited)
end