class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    # @destination = Destination.find(params[:id])



    # Get the token
    # amadeus = Amadeus::Client.new({
    #   client_id: ENV["AMADEUS_CLIENT_ID"],
    #   client_secret: ENV["AMADEUS_CLIENT_SECRET"],
    # })

    # base_url = "https://test.api.amadeus.com/v1/reference-data/locations?subType=AIRPORT&keyword=#{:query}&page%5Blimit%5D=10&page%5Boffset%5D=0&sort=analytics.travelers.score&view=FULL"

    # # @destination = Destination.new
    # # @destination.departure_city = params[:departure_city]
    # # @departure_city = params[:departure_city]
    # # response = amadeus.reference_data.locations.get(region_name: params['regionName'], iata: ['iata'])
    # # render json: response.data.to_json
    # airports = amadeus.reference_data.locations.get(
    #   keyword: params[:query],
    #   subType: Amadeus::Location::ANY
    # )


  end

end
