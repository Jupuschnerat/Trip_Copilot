class RouteSuggestionsService
  # Get the token
  def self.get_token
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
  end # End of get_token

    # Find cities to fly from a given origin
  def self.find_cities_to_fly(origin, budget, token)
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
    end # End of begin
  end # End of find_cities_to_fly
end
