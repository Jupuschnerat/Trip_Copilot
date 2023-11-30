class CreateDestinations < ActiveRecord::Migration[7.1]
  def change
    create_table :destinations do |t|
      t.float :price
      t.string :transportation
      t.date :departure_day
      t.references :route, null: false, foreign_key: true
      # save IATA code of the destination

      t.timestamps
    end
  end
end
