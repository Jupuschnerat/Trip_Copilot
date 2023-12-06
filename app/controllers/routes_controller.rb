require "json"
require "open-uri"
require "net/http"

class RoutesController < ApplicationController
  before_action :set_route, only: [:show]

  def new
    @route = Route.new
  end # End of new

  def show
    @total_price = @route.total_price
  end

  def details
    @user = current_user
    @route = Route.find(params[:id])
    # additional details logic
  end

  def create
    @route = Route.new(route_params)
    @route.user = current_user
    @route.save

    token = get_amadeus_token
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

  def button_to_favorite(route)
    if current_user.favorite_routes.include?(route)
      button_to "Remove from Favorites", favorite_path(route), method: :delete, remote: true
    else
      button_to "Add to Favorites", favorites_path(route_id: route.id), method: :post, remote: true
    end
  end

  # def favorite_routes
  #   # grabbing the route
  #   @route = Route.all.find(params[:id])
  #   # creating a favorite route with that route and current user's id
  #   Favorite.create(user_id: current_user.id, route_id: @route.id)
  #   # redirecting to the route's show page
  #   redirect_to route_path(@route)
  # end # End of favorite

  private

  def set_route
    @route = Route.find(params[:id])
  end # End of set_route

  def route_params
    params.require(:route).permit(:departure_place, :budget)
  end # End of route_params

end
