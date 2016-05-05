class EventsController < ApplicationController
  before_action :authenticate!

  def create
    @itinerary = current_user.itineraries.find(params[:itinerary_id])
    @pitstop = @itinerary.pitstops.create(date_visited: params["local_datetime"])
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

  # private
  # def event_params
  # 	params.permit(:game_number)
  # end

end
