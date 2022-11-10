class CreateTourOption < ActiveRecord::Migration[5.2]
  def change
    create_table :tour_options do |t|
      t.integer "tour_id"
      t.string "title_ru"
      t.string "title_en"
      t.integer "option_type", default: 0, null: false
      t.boolean "removed", default: false, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["option_type"], name: "index_tour_options_on_option_type"
      t.index ["removed"], name: "index_tour_options_on_removed"
      t.index ["title_en"], name: "index_tour_options_on_title_en"
      t.index ["title_ru"], name: "index_tour_options_on_title_ru"
      t.index ["tour_id"], name: "index_tour_options_on_tour_id"
    end
  end
end
