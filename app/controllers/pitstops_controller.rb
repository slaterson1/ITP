class PitstopsController < ApplicationController
  before_action :authenticate!

  def create
    itinerary = Itinerary.find[:id]
    if itinerary.pitstops.last
      i = itinerary.pitstops.last
      @pitstop = itinerary.pitstops.new(city: params['city'],
                                        stop_number: (i.stop_number + 1))
    else
      @pitstop = itinerary.pitstops.new(city: params['city'],
                                        stop_number: 1)
    end
    render "create.json.jbuilder", status: :created
  end

  def show
    @pitstop = Pitstop.find_by[stop_number: params['stop_number']]
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
