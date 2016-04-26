class EventsController < ApplicationController
  before_action :authenticate!
  include HTTParty
  base_uri "https:https://api.seatgeek.com/2/events?per_page=15&taxonomies.id=1010100&"

  def initialize
    @headers = {
      "Authorization" =>  ENV["MYCLIENTID"]
      "User-Agent"    =>  "HTTParty"
    }
    @zip = nil
    @begin_date = nil
    @end_date = nil
  end

  def real_date?(year, month, day)
    r1 = false
    r2 = false
    r3 = false
    result = false
    year.between?(2016, 2100)? r1 = true : r1 = false
    thirty_day = Set.new([4, 6, 9, 11])
    month.between?(1, 12)? r2 = true : r2 = false
    if month == 2 && year % 4 == 0
      day < 30? r3 = true : r3 = false
    elsif month == 2 && year % 4 != 0
      day < 29? r3 = true : r3 = false
    elsif thirty_day.include?(month)
      day < 31? r3 = true : r3 = false
    else
      day < 32? r3 = true : r3 = false
    end
    (r1 == true && r2 == true && r3 == true)? result = true : result = false
    result
  end

  def list_seatgeek
    App.get(
    "geoip=#{@zip}&range=300mi&datetime_local.gte=#{@begin_date}&datetime_local.lte=#{end_date}",
    headers: @headers)
  end

  def get_zip

  end

  def get_local_datetime

  end

  def create
    itinerary = Itinerary.find["id"]
    @event = itinerary.events.create()
  end

  def price_filter
    @event = Event.where("price < :price", price: params[:price])
  end
end
