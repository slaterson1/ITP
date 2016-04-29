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
    @itinerary = current_user.itineraries.find_by(start_date: params["start_date"])
    @itinerary.destroy
    render plain: "ITINERARY DESTROYED",
    status: :accepted
  end

	def expired?
		expired = false
		@itinerary = current_user.itineraries.find["id"]
		pitstop = @itinerary.pitstops.find["id"]
		last_event = pitstop.events.last
		last_date = last_event.local_datetime
		if DateTime.now > last_date
			expired = true
		end
		expired
	end

	def closed?
		result = false
		if expired?
			result = true
		end
		result
	end
end
