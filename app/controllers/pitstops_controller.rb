class PitstopsController < ApplicationController
  before_action :authenticate!

  def create
    itinerary = Itinerary.find[:id]
    @pitstop = itinerary.pitstops.new(city: params['city'])
    render "create.json.jbuilder", status: :created
  end

  def show
    itinerary = Itinerary.find[:id]
    @pitstop = itinerary.pitstops.find_by[stop_number: params['stop_number']]
    @event = @pitstop.events.all
    render "show.json.jbuilder", status: :ok
  end

  def update
    itinerary = Itinerary.find["id"]
    @itinerary = itinerary.pitstops["id"]
    @itinerary.update(city: params['city'])
    render "create.json.jbuilder", status: :ok
  end

  def destroy
    itinerary = Itinerary.find["id"]
    @pitstop = itinerary.pitstops.find_by(start_date: params["start_date"])
    @pitstop.destroy
    render plain: "PITSTOP DESTROYED",
    status: :accepted
  end
end
