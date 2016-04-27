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
  	SeatGeek.new(zip: nil, start_date: params[:start_date]).get_first_game
  end	

end
