class PitstopsController < ApplicationController
  before_action :authenticate!

  def create
    itinerary = Itinerary.last
    @pitstop = itinerary.pitstops.new(date_visited: params["local_datetime"])
    s = Seatgeek.new(@pitstop.date_visited)
    seatgeek = s.get_games
    render json: seatgeek, status: :ok
  end

  def show
    itinerary = Itinerary.find[:id]
    @pitstop = itinerary.pitstops.find[:id]
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
    @pitstop = itinerary.pitstops.find["id"]
    @pitstop.events.each do |event|
      event.destroy
    end
    @pitstop.destroy
    render plain: "PITSTOP DESTROYED",
    status: :accepted
  end
end
