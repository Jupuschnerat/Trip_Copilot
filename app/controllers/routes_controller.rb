class RoutesController < ApplicationController
  before_action :set_route, only: [:show, :edit, :update, :destroy]

  # as a user I can check all the routes of my search
  # GET /routes


  # as a user I can see more detailes of an specific route
  # GET /routes/:route_id


  # as a user I can search?create? a new route
  # GET routes/new


  # as a user I can search?create a new route
  # POST /routes




  private

  def set_route
    @route = Route.find(params[:route_id])
  end

  def route_params
    params.require(:route).permit(:departure_place, :duration, :budget)
  end
end
