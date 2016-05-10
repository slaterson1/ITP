class Seatgeek
  include HTTParty
  base_uri "https://api.seatgeek.com/2"
  format :json

  def initialize
    @headers = {
          "Authorization" =>  ENV["MYCLIENTID"],
          "User-Agent"    =>  "HTTParty"
      }
        @defaults = {
          "per_page" => 15,
          "taxonomies.id" => 1010100
        }
  end

  def get_first_game(start_date)
    @start_date = start_date
    @end_date = (start_date.to_date + 1.day).strftime("%Y-%m-%d")

    options = {
      "datetime_local.gte" => @start_date,
      "datetime_local.lte" => @end_date
    }
    params = @defaults.merge(options)
    query = Seatgeek.get("/events", query: params, headers: @headers)
  end

  def get_games(start_date)
    @start_date = start_date
    @end_date = (start_date.to_date + 1.day).strftime("%Y-%m-%d")

    options = {
      "datetime_local.gte" => @start_date,
      "datetime_local.lte" => @end_date
    }
    params = @defaults.merge(options)

    query = Seatgeek.get("/events", query: params, headers: @headers)
  end

  def all_games(game_ids)
    options = {
      "id" => game_ids
    }
    params = @defaults.merge(options)

    query = Seatgeek.get("/events", query: params, headers: @headers)
  end   
  
  def get_events(start_date)
    result = 0
    get_games(start_date).each do |events|
      result = events
    end
    result
  end

  def get_game_number(game_number, start_date)
    result = get_events(start_date)[1][0]
    get_events(start_date)[1].each do |event|
      if event["id"] == game_number
        result = event
      end
    end
    result
  end

  def event_array(game_number, start_date)
    result = []
    my_event = get_events(start_date)[1][0]
    get_events(start_date)[1].each do |event|
      if event["id"] == game_number
        my_event = event
      end
    end
    result.push(my_event["title"])
    result.push("lat: #{my_event["venue"]["location"]["lat"]}, lon: #{my_event["venue"]["location"]["lon"]}")
    result.push(my_event["venue"]["city"])
    result.push(my_event["venue"]["state"])
    result.push(my_event["venue"]["postal_code"])
    result.push(my_event["venue"]["address"])
    result.push(my_event["stats"]["lowest_price"])
    result.push(my_event["stats"]["highest_price"])
    result.push(my_event["stats"]["average_price"])
    result.push(my_event["performers"][0]["image"])
    result.push(my_event["performers"][1]["url"])
    result.push(my_event["datetime_local"])
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
