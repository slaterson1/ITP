json.iteneraries @iteneraries do |itenerary|
  json.user_id itenerary.user_id
  json.zip itenerary.zip
  json.start_date itenerary.start_date

  json.pitstops itinerary.pitstops do |pitstop|
    json.itinerary_id pitstop.itinerary_id
    json.date_visited pitstop.date_visited
    json.stop_number pitstop.stop_number
    json.zip pitstop.zip
  end	
end			