class RoutesController < ApplicationController
  before_action :set_route, only: [:show, :edit, :update, :destroy]

  # as a user I can check all the routes of my search
  # GET /routes
  def index
    @routes = Routes.all
    # search by city?
  end

  # as a user I can see more detailes of an specific route
  # GET /routes/:route_id
  def show

  end

  # as a user I can create a new route
  # GET routes/new
  def new
    @route = Routes.new
  end

  # as a user I can create a new route
  # POST /routes
  def create
    @route = Route.new(route_params)
    @route.user = current_user
  end

  # PATCH/PUT /routes/:route_id
  def update

  end

  # GET /routes/:route_id/edit
  # as I user I can edit a route
  def edit

  end

  # DELETE /routes/:route_id
  # as a user I can destroy a route
  def destroy

  end

  private

  def set_route
    @route = Route.find(params[:route_id])
  end

  def route_params
    params.require(:route).permit()
  end
end
