class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorited_routes = current_user.favorite_routes
  end

  # def favorite_routes
  #   # grabbing the route
  #   @route = Route.all.find(params[:id])
  #   # creating a favorite route with that route and current user's id
  #   Favorite.create(user_id: current_user.id, route_id: @route.id)
  #   # redirecting to the route's show page
  #   redirect_to favorites_path
  # end # End of favorite

  def create
    @route = Route.find(params[:route_id])
    @favorite = Favorite.new
    @favorite.user = current_user
    @favorite.route = @route
    @favorite.save!
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  def destroy
    @route = Route.find(params[:id])
    @favorite = Favorite.find_by(user: current_user, route: @route)
    @favorite.destroy
    # current_user.favorite_routes.destroy(@route)
    redirect_to favorites_path
  end
end
