class CreateTourPriceItem < ActiveRecord::Migration[5.2]
  def change
    create_table :tour_price_items do |t|
      t.integer "tour_id"
      t.date "date_beginning"
      t.date "date_completion"
      t.integer "total_places", default: 1, null: false
      t.integer "free_places", default: 1, null: false
      t.integer "price", default: 100, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.boolean "deleted", default: false, null: false
      t.string "currency"
      t.index ["date_beginning"], name: "index_tour_price_items_on_date_beginning"
      t.index ["date_completion"], name: "index_tour_price_items_on_date_completion"
      t.index ["free_places"], name: "index_tour_price_items_on_free_places"
      t.index ["price"], name: "index_tour_price_items_on_price"
      t.index ["total_places"], name: "index_tour_price_items_on_total_places"
      t.index ["tour_id"], name: "index_tour_price_items_on_tour_id"
    end
  end
end
