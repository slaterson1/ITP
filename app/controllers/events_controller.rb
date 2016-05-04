class EventsController < ApplicationController
  before_action :authenticate!

  def create
    @itinerary = current_user.itineraries.where(user_id: user.id).first_or_create
    @pitstop = @itinerary.pitstops.where(itinerary_id: @itinerary.id).first_or_create
    @event = @pitstop.events.create(local_datetime: params["local_datetime"], game_number: params["game_number"])
    render "create.json.jbuilder", status: :created
  end
end
