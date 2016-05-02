class ItineraryController < ApplicationController
	before_action :authenticate!

	def create
		@itinerary = current_user.itineraries.create(start_date: params["start_date"],
																	start_city: params["start_city"],
																	travel_days: params["travel_days"])
		render "create.json.jbuilder", status: :created
	end

	def update
		@itinerary = current_user.itineraries.find["id"]
		@itinerary.update(start_date: params["start_date"],
											start_city: params["start_city"],
											travel_days: params["travel_days"])
		render "create.json.jbuilder", status: :ok
	end

	def show
		@itinerary = current_user.itineraries.find_by(start_date: params["start_date"])
		@pitstops = @itinerary.pitstops.all
		render "show.json.jbuilder", status: :ok
	end

	def destroy
    @itinerary = current_user.itineraries.last
    pitstops = Pitstop.where(itinerary_id: @itinerary.id)
    pitstops.each do |pitstop|
      events = Event.where(pitstop_id: pitstop.id)
      events.each do |event|
        event.destroy
      end
      pitstop.destroy
    end
    @itinerary.destroy
    render "show.json.jbuilder", status: :ok
  end

  def reduce
    @event = Event.find[:id]
    @pitstop = Pitstop.find_by(id: @event.pitstop_id)
    pitstops = Pitstop.where("stop_number >= #{@pitstop.stop_number}")
    pitstops.each do |pitstop|
      events = Event.where(pitstop_id: pitstop.id)
      events.each do |event|
        event.destroy
      end
      pitstop.destroy
    end
    render "show.json.jbuilder", status: :ok
  end
end
