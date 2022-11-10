class CreateSeoDataItem < ActiveRecord::Migration[5.2]
  def change
    create_table :seo_data_items do |t|
      t.integer "country_id"
      t.integer "region_id"
      t.integer "city_id"
      t.integer "tour_type_id"
      t.integer "tour_category_id"
      t.integer "public_page_type"
      t.string "image"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "large_image"
      t.text "text_above_ru"
      t.text "text_above_en"
      t.text "text_below_ru"
      t.text "text_below_en"
      t.string "meta_title_ru"
      t.string "meta_title_en"
      t.text "meta_description_ru"
      t.text "meta_description_en"
      t.string "meta_keywords_ru"
      t.string "meta_keywords_en"
      t.index ["city_id"], name: "index_seo_data_items_on_city_id"
      t.index ["country_id"], name: "index_seo_data_items_on_country_id"
      t.index ["image"], name: "index_seo_data_items_on_image"
      t.index ["public_page_type"], name: "index_seo_data_items_on_public_page_type"
      t.index ["region_id"], name: "index_seo_data_items_on_region_id"
      t.index ["tour_category_id"], name: "index_seo_data_items_on_tour_category_id"
      t.index ["tour_type_id"], name: "index_seo_data_items_on_tour_type_id"
    end
  end
end
