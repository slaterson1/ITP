class Seatgeek
  include HTTParty
  base_uri "https://api.seatgeek.com/2"
  format :json

  def initialize(start_date)
    @headers = {
          "Authorization" =>  ENV["MYCLIENTID"],
          "User-Agent"    =>  "HTTParty"
      }
        @defaults = {
          "per_page" => 15,
          "taxonomies.id" => 1010100
        }
    @start_date = start_date
    end_date = start_date.to_date + 1.day
    @end_date = end_date.strftime("%Y-%m-%d")
    @start_date2 = @end_date
    end_date2 = start_date.to_date + 2.day
    @end_date2 = end_date2.strftime("%Y-%m-%d")
  end

  def get_first_game
    options = {
      "datetime_local.gte" => @start_date,
      "datetime_local.lte" => @end_date
    }
    params = @defaults.merge(options)
    query = Seatgeek.get("/events", query: params, headers: @headers)
  end

  def get_games
    options = {
      "datetime_local.gte" => @start_date2,
      "datetime_local.lte" => @end_date2
    }
    params = @defaults.merge(options)

    query = Seatgeek.get("/events", query: params, headers: @headers)
  end

  def get_events
    result = 0
    get_games.each do |events|
      result = events
    end
    result
  end

  def get_game_number(game_number)
    result = get_events[1][0]
    get_events[1].each do |event|
      if event["id"] == game_number
        result = event
      end
    end
    result
  end

  def get_team(game_number)
    get_game_number(game_number)["title"]
  end

  def get_gps_location(game_number)
    lat = get_game_number(game_number)["venue"]["location"]["lat"]
    lon = get_game_number(game_number)["venue"]["location"]["lon"]
    result = "lat:#{lat}, lon:#{lon}"
    result
  end

  def get_city(game_number)
    get_game_number(game_number)["venue"]["city"]
  end

  def get_state(game_number)
    get_game_number(game_number)["venue"]["state"]
  end

  def get_zip(game_number)
    get_game_number(game_number)["venue"]["postal_code"]
  end

  def get_street_address(game_number)
    get_game_number(game_number)["venue"]["address"]
  end

  def get_low_price(game_number)
    get_game_number(game_number)["stats"]["lowest_price"]
  end

  def get_high_price(game_number)
    get_game_number(game_number)["stats"]["highest_price"]
  end

  def get_average_price(game_number)
    get_game_number(game_number)["stats"]["average_price"]
  end

  def get_venue_photo(game_number)
    get_game_number(game_number)["performers"][0]["image"]
  end

  def get_ticket_url(game_number)
    get_game_number(game_number)["performers"][1]["url"]
  end

  def get_local_datetime(game_number)
    get_game_number(game_number)["datetime_local"]
  end
end
