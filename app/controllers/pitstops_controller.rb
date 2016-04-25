class PitstopsController < ApplicationController
  before_action :authenticate!

  def create
    itinerary = Itinerary.find[:id]
    @pitstop = itinerary.pitstops.new(city: params['city'])
  end
end
