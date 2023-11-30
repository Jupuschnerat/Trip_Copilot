require "json"
require "open-uri"

class RoutesController < ApplicationController
  before_action :set_route, only: [:show]

  # as a user I can check all the routes of my search
  # GET /routes


  # as a user I can see more detailes of an specific route
  # GET /routes/:route_id


  # as a user I can search?create? a new route
  # GET routes/new
  def new
    @route = Route.new
  end

  def show

  end


  # as a user I can search?create a new route
  # POST /routes
  def create
    # raise
    @route = Route.new(route_params)
    @route.user = current_user
    @route.save

    # Get the toke
    uri = URI.parse("https://test.api.amadeus.com/v1/security/oauth2/token")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.request_uri)
    request['Content-Type'] = 'application/x-www-form-urlencoded'
    request.body = "grant_type=client_credentials&client_id=#{ENV["AMADEUS_CLIENT_ID"]}&client_secret=#{ENV["AMADEUS_CLIENT_SECRET"]}"

    response = http.request(request)

    api_return_json = JSON.parse(response.body)

    p api_return_json["access_token"]

    base_url = "https://test.api.amadeus.com/v1/shopping/flight-destinations?origin=#{@route.departure_place}&maxPrice=#{@route.budget.floor}"
    headers = {
      'Authorization' => "Bearer #{api_return_json["access_token"]}"
    }


    url = base_url
    api_return = URI.open(url, headers).read
    api_return_json = JSON.parse(api_return)
    flights = api_return_json["data"]
    ordered_flights = flights.sort_by { |flight| flight['price']['total']}
    cheapest_flight = ordered_flights[0]
    origin = cheapest_flight["origin"]
    p cheapest_flight

    #creating destinations
    @destination = Destination.new()
    @destination.price = (cheapest_flight["price"]["total"].to_i)/2
    @destination.transportation = "plane"
    @destination.departure_day = cheapest_flight["departureDate"]
    @destination.arrival_date = cheapest_flight["departureDate"]
    @destination.departure_city = cheapest_flight["origin"]
    @destination.arrival_city = cheapest_flight["destination"]

    @destination.route = @route
    @destination.save

    #updating budget



    redirect_to route_path(@route)

  end





  private

  def set_route
    @route = Route.find(params[:id])
  end

  def route_params
    params.require(:route).permit(:departure_place, :budget)
  end
end
