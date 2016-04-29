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
end
