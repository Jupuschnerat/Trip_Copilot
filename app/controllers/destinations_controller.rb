class DestinationsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show ]
  before_action :set_destination, only: [:show]

  # as a user I can check all the destinations of my route
  # GET /destinations
  # def index
    # @destinations = Destination.all
  # end

  # as a visitor I can see more detailes of an specific destination
  # GET /destinations/:destination_id
  # def show
    # @destination = Destination.find(params[:id])



    # # Get the token
    # amadeus = Amadeus::Client.new({
    #   client_id: ENV["AMADEUS_CLIENT_ID"],
    #   client_secret: ENV["AMADEUS_CLIENT_SECRET"],
    # })

    # base_url = "https://test.api.amadeus.com/v1/reference-data/locations?subType=AIRPORT&keyword=#{:query}&page%5Blimit%5D=10&page%5Boffset%5D=0&sort=analytics.travelers.score&view=FULL"
    # @destination = Destination.new
    # @destination.departure_city = params[:departure_city]
    # @departure_city = params[:departure_city]
    # response = amadeus.reference_data.locations.get(region_name: params['regionName'], iata: ['iata'])
    # render json: response.data.to_json
  # end



  private

  def set_destination
    @destination = destination.find(params[:destination_id])
  end

  def destination_params
    params.require(:destination).permit()
  end
end
