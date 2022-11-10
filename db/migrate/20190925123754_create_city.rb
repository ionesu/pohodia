class CreateCity < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|
      t.integer "country_id", null: false
      t.boolean "important", null: false
      t.integer "region_id"
      t.string "title_ru", limit: 150
      t.string "area_ru", limit: 150
      t.string "region_ru", limit: 150
      t.string "title_en", limit: 150
      t.string "area_en", limit: 150
      t.string "region_en", limit: 150
      t.text "description_ru"
      t.text "description_en"
      t.string "avatar"
      t.string "large_avatar"
      t.string "slug_ru"
      t.string "slug_en"
      t.string "meta_title_ru"
      t.string "meta_title_en"
      t.text "meta_description_ru"
      t.text "meta_description_en"
      t.string "meta_keywords_ru"
      t.string "meta_keywords_en"
      t.string "iso_code"
      t.datetime "created_at", default: "2018-09-18 07:34:12", null: false
      t.datetime "updated_at", default: "2018-09-18 07:34:12", null: false
      t.index ["area_en"], name: "index_area_en"
      t.index ["area_ru"], name: "index_area_ru"
      t.index ["avatar"], name: "index_avatar2"
      t.index ["country_id"], name: "index_country_id1"
      t.index ["iso_code"], name: "index_iso_code2"
      t.index ["large_avatar"], name: "index_large_avatar2"
      t.index ["meta_description_en"], name: "index_meta_description_en2"
      t.index ["meta_description_ru"], name: "index_meta_description_ru2"
      t.index ["meta_keywords_en"], name: "index_meta_keywords_en2"
      t.index ["meta_keywords_ru"], name: "index_meta_keywords_ru2"
      t.index ["meta_title_en"], name: "index_meta_title_en2"
      t.index ["meta_title_ru"], name: "index_meta_title_ru2"
      t.index ["region_en"], name: "index_region_en"
      t.index ["region_id"], name: "index_region_id"
      t.index ["region_ru"], name: "index_region_ru"
      t.index ["slug_en"], name: "index_slug_en2"
      t.index ["slug_ru"], name: "index_slug_ru2"
      t.index ["title_en"], name: "index_title_en2"
      t.index ["title_ru"], name: "index_title_ru1"
    end
  end
end
