require "json"
require "open-uri"
require "net/http"

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



    # Get the token
    uri = URI.parse("https://test.api.amadeus.com/v1/security/oauth2/token")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.request_uri)
    request['Content-Type'] = 'application/x-www-form-urlencoded'
    request.body = "grant_type=client_credentials&client_id=#{ENV["AMADEUS_CLIENT_ID"]}&client_secret=#{ENV["AMADEUS_CLIENT_SECRET"]}"

    response = http.request(request)

    api_return_json = JSON.parse(response.body)

    # get the cheapest flight
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

    # block to be removed when using the loop
    @destination = Destination.new()
    @destination.price = (cheapest_flight["price"]["total"].to_i)/2
    @destination.transportation = "plane"
    @destination.departure_day = cheapest_flight["departureDate"]
    @destination.arrival_date = cheapest_flight["departureDate"]
    @destination.departure_city = cheapest_flight["origin"]
    @destination.arrival_city = cheapest_flight["destination"]
    @destination.route = @route
    @destination.save


    budget = @route.budget
    @route.total_price = 0



    # if budget > (cheapest_flight["price"]["total"].to_i)/2
    #   while budget > (cheapest_flight["price"]["total"].to_i)/2
    #   #creating destinations
    #     @destination = Destination.new()
    #     @destination.price = (cheapest_flight["price"]["total"].to_i)/2
    #     @destination.transportation = "plane"
    #     @destination.departure_day = cheapest_flight["departureDate"]
    #     @destination.arrival_date = cheapest_flight["departureDate"]
    #     @destination.departure_city = cheapest_flight["origin"]
    #     @destination.arrival_city = cheapest_flight["destination"]
    #     @destination.route = @route
    #     @destination.save

    #     #update budget and route total price
    #     budget -= @destination.price
    #     @route.total_price += @destination.price

    #     #updating api call

    #     # Get the token
    #     uri = URI.parse("https://test.api.amadeus.com/v1/security/oauth2/token")
    #     http = Net::HTTP.new(uri.host, uri.port)
    #     http.use_ssl = true

    #     request = Net::HTTP::Post.new(uri.request_uri)
    #     request['Content-Type'] = 'application/x-www-form-urlencoded'
    #     request.body = "grant_type=client_credentials&client_id=#{ENV["AMADEUS_CLIENT_ID"]}&client_secret=#{ENV["AMADEUS_CLIENT_SECRET"]}"
    #     response = http.request(request)
    #     api_return_json = JSON.parse(response.body)

    #     # Make the call again
    #     base_url = "https://test.api.amadeus.com/v1/shopping/flight-destinations?origin=#{@destination.arrival_city}&maxPrice=#{budget.floor}"

    #     headers = {
    #       'Authorization' => "Bearer #{api_return_json["access_token"]}"
    #     }
    #     sleep 10
    #     url = base_url
    #     conn = Faraday.new(
    #       headers: headers
    #     )
    #     response = conn.get(base_url)
    #     debugger
    #     # api_return = URI.open(url, headers).read
    #     api_return_json = JSON.parse(response.body)
    #     flights = api_return_json["data"]
    #     ordered_flights = flights.sort_by { |flight| flight['price']['total']}
    #     cheapest_flight = ordered_flights[0]
    #     origin = cheapest_flight["origin"]

    #   end
    # else
    #   p 'No routes for you.'
    # end

    redirect_to route_path(@route)

  end

  def favorite
    # grabbing the route
    @route = Route.all.find(params[:id])
    # creating a favorite route with that route and current user's id
    Favorite.create(user_id: current_user.id, route_id: @route.id)
    # redirecting to the route's show page
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
