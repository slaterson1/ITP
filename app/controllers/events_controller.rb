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
    d = Date.parse(local_datetime)
    if !real_date?(d.year, d.month, d.day)
      render json: { errors: "Date must be relevant and in YYYY-MM-DD format" },
                  status: :unauthorized
    else
    	s = Seatgeek.new(zip, local_datetime)
      seatgeek = s.get_first_game
      render json: seatgeek,
      status: :ok
    end
  end

  def next_event
    zip = params[:zip]
    local_datetime = params[:local_datetime]
    d = Date.parse(local_datetime)
    if !real_date?(d.year, d.month, d.day)
      render json: { errors: "Date must be relevant and in YYYY-MM-DD format" },
                  status: :unauthorized
    else
    	s = Seatgeek.new(zip, local_datetime)
    	seatgeek = s.get_games
      render json: seatgeek,
      status: :ok
    end
  end

end
