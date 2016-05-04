class EventsController < ApplicationController
  before_action :authenticate!

  def create
    @itinerary = current_user.itineraries.last
    @pitstop = @itinerary.pitstops.last
    @event = @pitstop.event.new(local_datetime: params["local_datetime"], game_number: params["game_number"])
    @event.save!
    render "create.json.jbuilder", status: :created
  end
end
