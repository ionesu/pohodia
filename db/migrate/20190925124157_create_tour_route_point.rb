class CreateTourRoutePoint < ActiveRecord::Migration[5.2]
  def change
    create_table :tour_route_points do |t|
      t.integer "tour_route_id", null: false
      t.string "geo_latitude"
      t.string "geo_longitude"
      t.integer "position"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
