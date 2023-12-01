import { Controller } from "@hotwired/stimulus"
<<<<<<< HEAD
import Amadeus from "amadeus"
// Connects to data-controller="locationautocomplete"
var amadeus = new Amadeus({
  clientId: 'REPLACE_BY_YOUR_API_KEY',
  clientSecret: 'REPLACE_BY_YOUR_API_SECRET'
});

amadeus.shopping.flightOffersSearch.get({
    originLocationCode: 'SYD',
    destinationLocationCode: 'BKK',
    departureDate: '2022-06-01',
    adults: '2'
}).then(function(response){
  console.log(response.data);
}).catch(function(responseError){
  console.log(responseError.code);
});
=======

// Connects to data-controller="locationautocomplete"
export default class extends Controller {
  connect() {
  }
}
>>>>>>> 0d16434bede3ca38f1811d70f179f5f59d05bcf4
