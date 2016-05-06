class EventsController < ApplicationController
  before_action :authenticate!

  def create
    @itinerary = current_user.itineraries.find(params[:itinerary_id])
    @pitstop = @itinerary.pitstops.create(date_visited: params["date_visited"])
    @event = @pitstop.events.create(game_number: params["game_number"])

    updates = seatgeek_event_array
    @pitstop.update(city: "#{updates[2]}, #{updates[3]} #{updates[4]}")
    @event.update(team: updates[0],
                  gps_location: updates[1],
                  city: updates[2],
                  state: updates[3],
                  zip: updates[4],
                  street_address: updates[5],
                  low_price: updates[6],
                  high_price: updates[7],
                  average_price: updates[8],
                  venue_photo: updates[9],
                  ticket_url: updates[10],
                  local_datetime: updates[11])

  	render :json => { :itinerary => @itinerary.id,
        			      :pitstop => @pitstop.date_visited,
        			      :event => @event }
  end

  def next_event
  	@itinerary = current_user.itineraries.find(params[:itinerary_id])
  	@pitstop = @itinerary.pitstops.last

  	s = Seatgeek.new(@pitstop.date_visited)
    @seatgeek = s.get_games
    game_number = @pitstop.events.last.game_number

    render :json => { :local_datetime => s.get_local_datetime(game_number).to_date,
                      :seatgeek => @seatgeek }

  end

  def seatgeek_event_array
    @itinerary = current_user.itineraries.find(params[:itinerary_id])
    @pitstop = @itinerary.pitstops.last
    @event = @pitstop.events.first
    s = Seatgeek.new(@pitstop.date_visited.to_date - 1.day)
    s.event_array(@event.game_number)
  end
end
