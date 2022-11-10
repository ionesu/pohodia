class CreateTourImage < ActiveRecord::Migration[5.2]
  def change
    create_table :tour_images do |t|
      t.integer "tour_id"
      t.integer "administrator_id"
      t.integer "guide_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "image", null: false
      t.boolean "removed", default: false, null: false
      t.index ["administrator_id"], name: "index_tour_images_on_administrator_id"
      t.index ["guide_id"], name: "index_tour_images_on_guide_id"
      t.index ["tour_id"], name: "index_tour_images_on_tour_id"
    end
  end
end
