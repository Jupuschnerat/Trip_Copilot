class DestinationsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show ]
  before_action :set_destination, only: [:show]

  # as a user I can check all the destinations of my search
  # GET /destinations
  def index
    @destinations = destinations.all
  end

  # as a user I can see more detailes of an specific destination
  # GET /destinations/:destination_id
  def show

  end



  private

  def set_destination
    @destination = destination.find(params[:destination_id])
  end

  def destination_params
    params.require(:destination).permit()
  end
end
