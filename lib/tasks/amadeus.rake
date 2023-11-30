require "json"
require "open-uri"
require 'net/http'
require 'uri'

namespace :amadeus do

  desc "Get the results for the cheapest flights from somewhere"
  task flights: :environment do
    base_url = 'https://test.api.amadeus.com/v1/shopping/flight-destinations?origin=PAR&maxPrice=200'
    headers = {
      'Authorization' => "Bearer #{ENV["AMADEUS_API_TOKEN"]}"
    }
# endpoint =
# origin='PAR'

    url = base_url
    api_return = URI.open(url, headers).read
    api_return_json = JSON.parse(api_return)
    flights = api_return_json["data"]
    ordered_flights = flights.sort_by { |flight| flight['price']['total']}
    cheapest_flight = ordered_flights[0]
    origin = cheapest_flight["origin"]
    p cheapest_flight


  end


  desc "Get the token from the API"
  task token: :environment do
      uri = URI.parse("https://test.api.amadeus.com/v1/security/oauth2/token")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/x-www-form-urlencoded'
      request.body = "grant_type=client_credentials&client_id=#{ENV["AMADEUS_CLIENT_ID"]}&client_secret=#{ENV["AMADEUS_CLIENT_SECRET"]}"

      response = http.request(request)

      api_return_json = JSON.parse(response.body)

      p api_return_json["access_token"]

  end
end
