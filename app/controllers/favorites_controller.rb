class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @route = Route.find(params[:id])
    current_user.favorite_routes << @route
    @route.save
    redirect_to @route, notice: 'Route added to favorites!'
  end

  def destroy
    @route = Route.find(params[:id])
    current_user.favorite_routes.destroy(@route)
    redirect_to @route, notice: 'Route removed from favorites!'
  end
end
