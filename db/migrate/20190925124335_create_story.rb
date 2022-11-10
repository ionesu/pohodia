class CreateStory < ActiveRecord::Migration[5.2]
  def change
    create_table :stories do |t|
      t.string "title_ru"
      t.string "title_en"
      t.text "text_ru"
      t.text "text_en"
      t.integer "user_id"
      t.integer "administrator_id"
      t.integer "country_id"
      t.integer "region_id"
      t.integer "city_id"
      t.string "type_activity"
      t.string "image"
      t.string "large_image"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "tour_category_id"
      t.integer "guide_id"
    end
  end
end
