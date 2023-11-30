class AddArrivalCityAndDepartureCityToDestinations < ActiveRecord::Migration[7.1]
  def change
    add_column :destinations, :arrival_city, :string
    add_column :destinations, :departure_city, :string
  end
end
