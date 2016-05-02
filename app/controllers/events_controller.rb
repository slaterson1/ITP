class EventsController < ApplicationController
  before_action :authenticate!

  def create_first_event
    zip = params[:zip]
    local_datetime = params[:local_datetime]
    if !real_date?(local_datetime)
      render json: { errors: "Date must be relevant and in YYYY-MM-DD format" },
                  status: :unauthorized
    else
      @itinerary = current_user.itineraries.new(start_date: local_datetime,
  																	             zip: zip,
  																	             travel_days: 1)
      @itinerary.save!
      @pitstop = @itinerary.pitstops.new(zip: zip,
                                          stop_number: 1,
                                          date_visited: local_datetime)
      @pitstop.save!
      @event = @pitstop.events.new(zip: zip,
                                      local_datetime: local_datetime)
      @event.save!
      render "create.json.jbuilder", status: :created
    end
  end

  def create_next_event
    # if expired?
    #   render json: { errors: "ITINERARY IS CLOSED TO NEW PITSTOPS AND EVENTS!" },
    #               status: :unauthorized
    # else
      zip = params[:zip]
      @itinerary = current_user.itineraries.last
      previous_date = @itinerary.pitstops.last.date_visited
      previous_date = previous_date.to_date
      previous_date = previous_date.to_s
      @new_date = advance_a_day(previous_date)
      @pitstop = @itinerary.pitstops.new(zip: zip,
                                        stop_number: (@itinerary.pitstops.last.stop_number + 1),
                                        date_visited: @new_date)
      @pitstop.save!
      @itinerary.update(travel_days: (@itinerary.travel_days + 1))
      @event = @pitstop.events.new(zip: zip,
                                  local_datetime: @new_date)
      @event.save!
      render "create.json.jbuilder", status: :created
    # end
  end

  def first_event
    zip = params[:zip]
    local_datetime = params[:local_datetime]
    if !real_date?(local_datetime)
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
    @itinerary = current_user.itineraries.last
    previous_date = @itinerary.pitstops.last.date_visited
    previous_date = previous_date.to_date
    previous_date = previous_date.to_s
    zip = params[:zip]
    if !real_date?(previous_date)
      render json: { errors: "Date must be relevant and in YYYY-MM-DD format" },
                  status: :unauthorized
    else
      s = Seatgeek.new(previous_date)
      seatgeek = s.get_games
      render json: seatgeek,
      status: :ok
    end
  end

  def expired?
		expired = false
		@itinerary = current_user.itineraries.find["id"]
		pitstop = @itinerary.pitstops.find["id"]
		last_event = pitstop.events.last
		last_date = last_event.local_datetime
		if DateTime.now > last_date
			expired = true
		end
		expired
	end
end
