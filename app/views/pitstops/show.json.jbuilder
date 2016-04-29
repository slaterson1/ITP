json.pitstops @pitstop do |pitstop|
  json.(pitstop, :zip, :date_visited, :stop_number)
    json.events @event do |event|
      json.(event, :zip, :local_datetime)
    end
  end
end
