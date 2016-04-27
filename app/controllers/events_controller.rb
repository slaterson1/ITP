class EventsController < ApplicationController
  before_action :authenticate!

  def create
    itinerary = Itinerary.find["id"]
    @event = itinerary.events.create()
  end

  def price_filter
    @event = Event.where("price < :price", price: params[:price])
  end

  def first_event
    zip = params[:zip]
    local_datetime = params[:local_datetime]
  	s = SeatGeek.new(zip, local_datetime)
    seatgeek = s.get_first_game
    render json: seatgeek,
    status: :ok
  end

  def next_event
  	SeatGeek.new(zip: params[:zip], local_datetime: params[:local_datetime]).get_games
  end

end
