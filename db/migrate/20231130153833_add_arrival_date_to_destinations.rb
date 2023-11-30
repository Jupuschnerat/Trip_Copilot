class AddArrivalDateToDestinations < ActiveRecord::Migration[7.1]
  def change
    add_column :destinations, :arrival_date, :date
  end

end
