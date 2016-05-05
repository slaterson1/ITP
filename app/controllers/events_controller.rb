class EventsController < ApplicationController
  before_action :authenticate!

  def create
    @itinerary = current_user.itineraries.find(params[:itinerary_id])
 
    @pitstop = @itinerary.pitstops.find_or_create_by(date_visited: params["local_datetime"])
    @event = @pitstop.events.create(event_params)
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

    render json: @seatgeek, status: :ok
  end

  private
  
  def event_params
  	params.permit(:game_number)
  end

end
