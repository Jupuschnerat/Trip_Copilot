class RoutesController < ApplicationController
  before_action :set_route, only: [:show, :edit, :update, :destroy]

  # as a user I can check all the routes of my search
  # GET /routes


  # as a user I can see more detailes of an specific route
  # GET /routes/:route_id


  # as a user I can search?create? a new route
  # GET routes/new
  def new

  end




  # as a user I can search?create a new route
  # POST /routes
  def create
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
  end





  private

  def set_route
    @route = Route.find(params[:route_id])
  end

  def route_params
    params.require(:route).permit(:departure_place, :duration, :budget)
  end
end
