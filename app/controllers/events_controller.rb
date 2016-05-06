class EventsController < ApplicationController
  before_action :authenticate!

  def create
    @itinerary = current_user.itineraries.find(params[:itinerary_id])
    @pitstop = @itinerary.pitstops.create(date_visited: params["date_visited"])
  	s = Seatgeek.new(@pitstop.date_visited.to_date - 1.day)
    @event = @pitstop.events.create(game_number: params["game_number"])

    game_city = s.get_city(@event.game_number)
    game_state = s.get_state(@event.game_number)
    game_zip = s.get_zip(@event.game_number)
    @pitstop.update(city: "#{game_city}, #{game_state} #{game_zip}")
    @event.update(team: s.get_team(@event.game_number),
                  gps_location: s.get_gps_location(@event.game_number),
                  city: game_city,
                  state: game_state,
                  zip: game_zip,
                  street_address: s.get_street_address(@event.game_number),
                  low_price: s.get_low_price(@event.game_number),
                  high_price: s.get_high_price(@event.game_number),
                  average_price: s.get_average_price(@event.game_number),
                  venue_photo: s.get_venue_photo(@event.game_number),
                  ticket_url: s.get_ticket_url(@event.game_number),
                  local_datetime: s.get_local_datetime(@event.game_number))

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

end
