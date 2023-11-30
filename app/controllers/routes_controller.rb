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


    base_url = 'https://test.api.amadeus.com/v1/shopping/flight-destinations?origin=PAR&maxPrice=200'
    headers = {
      'Authorization' => "Bearer #{ENV["AMADEUS_API_TOKEN"]}"
    }
# endpoint =
# origin='PAR'

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
