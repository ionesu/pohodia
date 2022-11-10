class CreateRegion < ActiveRecord::Migration[5.2]
  def change
    create_table :regions do |t|
      t.integer "country_id", null: false
      t.string "title_ru", limit: 150
      t.string "title_en", limit: 150
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
      t.datetime "created_at", default: "2018-09-18 07:34:09", null: false
      t.datetime "updated_at", default: "2018-09-18 07:34:09", null: false
      t.index ["avatar"], name: "index_avatar1"
      t.index ["country_id"], name: "index_country_id"
      t.index ["iso_code"], name: "index_iso_code1"
      t.index ["large_avatar"], name: "index_large_avatar1"
      t.index ["meta_description_en"], name: "index_meta_description_en1"
      t.index ["meta_description_ru"], name: "index_meta_description_ru1"
      t.index ["meta_keywords_en"], name: "index_meta_keywords_en1"
      t.index ["meta_keywords_ru"], name: "index_meta_keywords_ru1"
      t.index ["meta_title_en"], name: "index_meta_title_en1"
      t.index ["meta_title_ru"], name: "index_meta_title_ru1"
      t.index ["slug_en"], name: "index_slug_en1"
      t.index ["slug_ru"], name: "index_slug_ru1"
      t.index ["title_en"], name: "index_title_en1"
      t.index ["title_ru"], name: "index_title_ru"
    end
  end
end
