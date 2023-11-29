require "json"
require "open-uri"

namespace :amadeus do

  desc "Get the results for the cheapest flights from somewhere"
  task update: :environment do
    base_url = 'https://test.api.amadeus.com/v1/shopping/flight-destinations?origin=PAR&maxPrice=200'
    headers = {
      'Authorization' => "Bearer #{ENV["AMADEUS_API_KEY"]}"
    }
# endpoint =
# origin='PAR'

    url = base_url
    api_return = URI.open(url, headers).read
    api_return_json = JSON.parse(api_return)

    p api_return_json
  end
end
