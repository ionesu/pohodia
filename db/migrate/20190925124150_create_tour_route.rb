class CreateTourRoute < ActiveRecord::Migration[5.2]
  def change
    create_table :tour_routes do |t|
      t.integer "tour_id", null: false
      t.integer "sorting_postion", default: 0, null: false
      t.integer "type_accomodation", default: 0, null: false
      t.integer "type_of_food", default: 0, null: false
      t.integer "distance", default: 0, null: false
      t.integer "time_hours", default: 0, null: false
      t.string "image"
      t.string "geo_latitude"
      t.string "geo_longitude"
      t.boolean "wifi_enabled", default: false, null: false
      t.boolean "electricity_enabled", default: false, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.boolean "removed", default: false, null: false
      t.boolean "cellular_network_enabled", default: false, null: false
      t.string "title_ru"
      t.string "title_en"
      t.text "description_ru"
      t.text "description_en"
      t.time "time"
      t.index ["distance"], name: "index_tour_routes_on_distance"
      t.index ["electricity_enabled"], name: "index_tour_routes_on_electricity_enabled"
      t.index ["geo_latitude"], name: "index_tour_routes_on_geo_latitude"
      t.index ["geo_longitude"], name: "index_tour_routes_on_geo_longitude"
      t.index ["image"], name: "index_tour_routes_on_image"
      t.index ["sorting_postion"], name: "index_tour_routes_on_sorting_postion"
      t.index ["time_hours"], name: "index_tour_routes_on_time_hours"
      t.index ["tour_id"], name: "index_tour_routes_on_tour_id"
      t.index ["type_accomodation"], name: "index_tour_routes_on_type_accomodation"
      t.index ["type_of_food"], name: "index_tour_routes_on_type_of_food"
      t.index ["wifi_enabled"], name: "index_tour_routes_on_wifi_enabled"
    end
  end
end
