class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home ]

  def home
    if params[:query].present?
      departure_place = params[:query]
      budget = 1000000 #setting unlimited budget for routes on home
      token = get_token
      cities_to_fly = find_cities_to_fly(departure_place, budget, token)
      # debugger
      if cities_to_fly[0] == 0
        @user_message = cities_to_fly[2]
        @results = 0
      else
        @origin = cities_to_fly[1][0]["origin"]
        @destination = cities_to_fly[1][0]["destination"]
        @price = (cities_to_fly[1][0]["price"]["total"].to_i)/2
        @results = 1
      end
    end
      # Can I create a route on pages#home
      # @route = Route.new(:departure_place params[:query])
  end


  private

  # ===== Methods used in the main =======
# Get the token
  def get_token
    uri = URI.parse("https://test.api.amadeus.com/v1/security/oauth2/token")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri)
    request['Content-Type'] = 'application/x-www-form-urlencoded'
    request.body = "grant_type=client_credentials&client_id=#{ENV["AMADEUS_CLIENT_ID"]}&client_secret=#{ENV["AMADEUS_CLIENT_SECRET"]}"
    response = http.request(request)
    response_json = JSON.parse(response.body)
    token = response_json["access_token"]
    return token
  end

  # Find cities to fly from a given origin
  def find_cities_to_fly(origin, budget, token)
    begin
      base_url = "https://test.api.amadeus.com/v1/shopping/flight-destinations?origin=#{origin}&maxPrice=#{budget.floor}"
      headers = {'Authorization' => "Bearer #{token}"}
      api_return = URI.open(base_url, headers).read
      api_return_json = JSON.parse(api_return)
      cities_to_go = api_return_json["data"] # Arry of hashes
      cities_to_go_ordered = cities_to_go.sort_by { |flight| flight['price']['total'].to_f}
      # debugger
      return [1, cities_to_go_ordered, 'Success']
    rescue
      return [0, 0, "No flights from this origin"]
    end
  end

end
