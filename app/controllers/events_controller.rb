class EventsController < ApplicationController
  before_action :authenticate!

  def create_first_event
    zip = params[:zip]
    local_datetime = params[:local_datetime]
    d = Date.parse(local_datetime)
    if !real_date?(d.year, d.month, d.day)
      render json: { errors: "Date must be relevant and in YYYY-MM-DD format" },
                  status: :unauthorized
    else
      itinerary = current_user.itineraries.create(start_date: local_datetime,
  																	             zip: zip,
  																	             travel_days: 1)
      @pitstop = itinerary.pitstops.create(zip: zip,
                                          stop_number: 1)
      @event = @pitstop.events.create(zip: zip,
                                      local_datetime: local_datetime)
      render "create.json.jbuilder", status: :created
    end
  end

  def create_next_event
    zip = params[:zip]
    local_datetime = params[:local_datetime]
    d = Date.parse(local_datetime)
    if !real_date?(d.year, d.month, d.day)
      render json: { errors: "Date must be relevant and in YYYY-MM-DD format" },
                  status: :unauthorized
    else
      itinerary = current_user.itineraries.last
      @pitstop = itinerary.pitstops.new(zip: zip,
                                        stop_number: (itinerary.stop_number + 1))
      itinerary.update(travel_days: (itinerary.travel_days + 1))
      @event = @pitstop.events.create(zip: zip,
                                      local_datetime: local_datetime)
      render "create.json.jbuilder", status: :created
    end
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
    	s = Seatgeek.new(local_datetime)
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
    	s = Seatgeek.new(local_datetime)
    	seatgeek = s.get_games(zip)
      render json: seatgeek,
      status: :ok
    end
  end

end
