class CreateSavedRoutes < ActiveRecord::Migration[7.1]
  def change
    create_table :saved_routes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :route, null: false, foreign_key: true

      t.timestamps
    end
  end
end
