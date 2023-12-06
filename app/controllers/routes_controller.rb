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
  end # End of show

  def details
    @user = current_user
    @route = Route.find(params[:id])
    # additional details logic
  end

  def create
    @route = Route.new(route_params)
    @route.user = current_user
    @route.save
    origin = @route.departure_place
    budget = @route.budget

    RouteSuggestionsService.build_route(origin, budget, @route)

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
end # End of RoutesController
