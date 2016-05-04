class EventsController < ApplicationController
  before_action :authenticate!

  def create
    @itinerary = current_user.itineraries.find_or_create_by(user_id: current_user.id)
    @pitstop = @itinerary.pitstops.find_or_create_by(itinerary_id: @itinerary.id)
    @event = @pitstop.events.create(local_datetime: params["local_datetime"], game_number: params["game_number"])
    
    s = Seatgeek.new(@pitstop.date_visited)
    seatgeek = s.get_games
    render json: seatgeek, status: :ok
  end
end
