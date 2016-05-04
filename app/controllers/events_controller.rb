class EventsController < ApplicationController
  before_action :authenticate!

  def create
    @itinerary = current_user.itineraries.last
    @pitstop = @itinerary.pitstops.last
    game_number = params["game_number"]
    s = Seatgeek.new(@pitstop.date_visited)
    @event = @pitstop.events.new(game_number: game_number,
                                team: s.get_team(game_number),
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
    @event.save!
    render "create.json.jbuilder", status: :created
  end
end
