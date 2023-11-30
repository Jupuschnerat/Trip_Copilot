class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.string :iata
      t.string :icao
      t.string :country_code
      t.string :region_name
      t.string :airport
      t.string :latitude
      t.string :longitude
      t.references :city, null: false, foreign_key: true

      t.timestamps
    end
  end
end
