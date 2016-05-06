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

  def event_array(game_number)
    result = []
    my_event = get_events[1][0]
    get_events[1].each do |event|
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

end
