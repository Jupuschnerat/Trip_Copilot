require "json"
require "open-uri"
require "net/http"

class RoutesController < ApplicationController
  before_action :set_route, only: [:show]

  def new
    @route = Route.new
  end # End of new

  def show
  end # End of show

  def create
    @route = Route.new(route_params)
    @route.user = current_user
    @route.save

    token = get_token
    number_of_destinations = 0
    origin = @route.departure_place
    budget = @route.budget
    stop_route_builder = 0

    while stop_route_builder == 0 && number_of_destinations < 3

      # Find possible cities to fly
      cities_to_fly = find_cities_to_fly(origin, budget, token)
      if cities_to_fly[0] == 0
        stop_route_builder = 1
        user_message = cities_to_fly[2]
        p user_message
        break # stops the loop
      end  # End of if


      # Define city to fly -> Define destination
      destination = define_destination(origin, cities_to_fly[1], number_of_destinations, budget, token)
      if destination[0] == 0
        stop_route_builder = 1
        user_message = destination[2]
      end # End of if

      # Persist destination on DB
      @destination = Destination.new()
      @destination.price = (destination[1][0]["price"]["total"].to_f)/2
      @destination.transportation = "plane"
      @destination.departure_day = destination[1][0]["departureDate"]
      @destination.arrival_date = destination[1][0]["departureDate"]
      @destination.departure_city = destination[1][0]["origin"]
      @destination.arrival_city = destination[1][0]["destination"]
      @destination.route = @route
      @destination.save

      # Updating budget, number_of_destinations and origin for next iteration
      number_of_destinations = destination[1][1]
      # debugger
      budget = destination[1][2]
      origin = @destination.arrival_city

      # Repeat the process -> Go back to the begin of the loop
    end # End of while

    redirect_to route_path(@route)
  end

  def favorite
    # grabbing the route
    @route = Route.all.find(params[:id])
    # creating a favorite route with that route and current user's id
    Favorite.create(user_id: current_user.id, route_id: @route.id)
    # redirecting to the route's show page
    redirect_to route_path(@route)
  end # End of favorite

  private

  def set_route
    @route = Route.find(params[:id])
  end # End of set_route

  def route_params
    params.require(:route).permit(:departure_place, :budget)
  end # End of route_params

  # ===== Methods used in the iteration =======
    # Get the token
  def get_token
    uri = URI.parse("https://test.api.amadeus.com/v1/security/oauth2/token")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri)
    request['Content-Type'] = 'application/x-www-form-urlencoded'
    request.body = "grant_type=client_credentials&client_id=#{ENV["AMADEUS_CLIENT_ID"]}&client_secret=#{ENV["AMADEUS_CLIENT_SECRET"]}"
    response = http.request(request)
    response_json = JSON.parse(response.body)
    token = response_json["access_token"]
    return token
  end # End of get_token

    # Find cities to fly from a given origin
  def find_cities_to_fly(origin, budget, token)
    begin
      base_url = "https://test.api.amadeus.com/v1/shopping/flight-destinations?origin=#{origin}&maxPrice=#{budget.floor}"
      headers = {'Authorization' => "Bearer #{token}"}
      api_return = URI.open(base_url, headers).read
      api_return_json = JSON.parse(api_return)
      cities_to_go = api_return_json["data"] # Arry of hashes
      cities_to_go_ordered = cities_to_go.sort_by { |flight| flight['price']['total'].to_f}
      # debugger
      return [1, cities_to_go_ordered, 'Success']
    rescue
      return [0, 0, "No flights from this origin"]
    end # End of begin
  end # End of find_cities_to_fly

    # Define a destination from a given city
  def define_destination(origin, cities_to_fly, number_of_destinations, budget, token)
    next_destination = nil
    i = 0
    while next_destination == nil || next_destination[0] == 0
      next_destination = find_cities_to_fly(cities_to_fly[i]["destination"], budget,token)
      if next_destination[0] == 1
        if (cities_to_fly[i]["price"]["total"].to_f)/2 < budget
          destination = cities_to_fly[i] # The city is a hash. Cities_to_fly is an array of hashs
          number_of_destinations += 1
          budget -= (cities_to_fly[i]["price"]["total"].to_f)/2
          return [1, [destination, number_of_destinations, budget], 'Sucess']
        else
          return [0, 1, "No budget to fly. Your trip ends on #{cities_to_fly[i]["origin"]}"]
        end # End of if
      end # End of if

      if i + 1 == cities_to_fly.length
        # If no cities has a next destination. We pick up the first possible city to be the destination
        destination = cities_to_fly[0]
        number_of_destinations += 1
        budget -= (cities_to_fly[i]["price"]["total"].to_f)/2
        # debugger
        return [1, [destination, number_of_destinations, budget], "You can't go further from #{origin}. Your trip ends on #{cities_to_fly[i]["origin"]}"]
      end # End of if
      i += 1
    end # End of while
  end  # End of define_destination
end # End of class
