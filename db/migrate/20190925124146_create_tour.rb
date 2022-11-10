class CreateTour < ActiveRecord::Migration[5.2]
  def change
    create_table :tours do |t|
      t.integer "administrator_id"
      t.integer "country_id"
      t.integer "region_id"
      t.integer "city_id"
      t.integer "tour_type_id"
      t.integer "tour_category_id"
      t.string "avatar"
      t.integer "complexity", default: 1, null: false
      t.integer "min_height", default: 700, null: false
      t.integer "max_height", default: 1000, null: false
      t.integer "length_of_route", default: 1, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "large_avatar"
      t.integer "guide_id"
      t.string "title_ru"
      t.string "title_en"
      t.string "description_ru"
      t.string "description_en"
      t.integer "global_status", default: 0, null: false
      t.datetime "deleted_at"
      t.integer "guide_company_id", default: 0
      t.integer "minimum_age", default: 5
      t.boolean "relocation_included", default: false, null: false
      t.boolean "confirmed", default: false
      t.boolean "many_days"
      t.boolean "has_booking_without_date", default: false
      t.boolean "has_booking", default: false
      t.integer "price"
      t.string "currency"
      t.string "external_url"
      t.string "location"
      t.string "avatar_external_url"
      t.index ["administrator_id"], name: "index_tours_on_administrator_id"
      t.index ["avatar"], name: "index_tours_on_avatar"
      t.index ["city_id"], name: "index_tours_on_city_id"
      t.index ["complexity"], name: "index_tours_on_complexity"
      t.index ["country_id"], name: "index_tours_on_country_id"
      t.index ["length_of_route"], name: "index_tours_on_length_of_route"
      t.index ["max_height"], name: "index_tours_on_max_heght"
      t.index ["min_height"], name: "index_tours_on_min_heght"
      t.index ["region_id"], name: "index_tours_on_region_id"
      t.index ["tour_category_id"], name: "index_tours_on_tour_category_id"
      t.index ["tour_type_id"], name: "index_tours_on_tour_type_id"
    end
  end
end
