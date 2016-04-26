class ItineraryController < ApplicationController
	before_action :authenticate!

	def new
		@itinerary = Itinerary.new
	end
end	 