class CreateRoutes < ActiveRecord::Migration[7.1]
  def change
    create_table :routes do |t|
      t.string :departure_place
      t.integer :duration
      t.float :budget
      t.float :total_price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
