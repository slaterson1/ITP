class EventsController < ApplicationController
  before_action :authenticate!

  def create
    @itinerary = current_user.itineraries.find(params[:itinerary_id])
    @pitstop = @itinerary.pitstops.create(date_visited: date_visited)
    @event = @pitstop.events.create(game_number: params["game_number"])

    # @event.update_from_seatgeek

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

  private
  def event_params(game_number)
    @pitstop = @itinerary.pitstops.last
  	s = Seatgeek.new(@pitstop.date_visited)
  	params.permit(team: s.get_team(game_number),
                  gps_location: s.get_gps_location(game_number),
                  city: s.get_city(game_number),
                  state: s.get_state(game_number),
                  zip: s.get_zip(game_number),
                  street_address: s.get_street_address(game_number),
                  low_price: s.get_low_price(game_number),
                  high_price: s.get_high_price(game_number),
                  average_price: s.get_average_price(game_number),
                  venue_photo: s.get_venue_photo(game_number),
                  ticket_url: s.get_ticket_url(game_number),
                  local_datetime: s.get_local_datetime(game_number)
                  )
  end

  def event_update_from_seatgeek
  end

end
