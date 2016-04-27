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
  	SeatGeek.new(zip, local_datetime).get_first_game
  end

  def next_event
  	SeatGeek.new(zip: params[:zip], local_datetime: params[:local_datetime]).get_games
  end

end
