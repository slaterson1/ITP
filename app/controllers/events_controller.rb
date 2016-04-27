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
    local_datetime = "2000-01-01"
    d = Date.parse(due_date)
    while !real_date?(d.year, d.month, d.day)
      render json: { errors: "Enter the date in which you would like to accomplish this task YYYY-MM-DD format:" },
      local_datetime = gets.chomp
      begin
        d = Date.parse(local_datetime)
      rescue ArgumentError
      end
    end
    local_datetime = params[:local_datetime]
  	s = Seatgeek.new(zip, local_datetime)
    seatgeek = s.get_first_game
    render json: seatgeek,
    status: :ok
  end

  def next_event
    zip = params[:zip]
    local_datetime = "2000-01-01"
    d = Date.parse(due_date)
    while !real_date?(d.year, d.month, d.day)
      render json: { errors: "Enter the date in which you would like to accomplish this task YYYY-MM-DD format:" },
      local_datetime = gets.chomp
      begin
        d = Date.parse(local_datetime)
      rescue ArgumentError
      end
    end
    local_datetime = params[:local_datetime]
  	s = Seatgeek.new(zip, local_datetime)
  	seatgeek = s.get_games
    render json: seatgeek,
    status: :ok
  end

end
