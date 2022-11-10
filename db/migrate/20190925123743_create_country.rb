class CreateCountry < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.string "title_ru", limit: 60
      t.string "title_en", limit: 60
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
      t.string "guides_meta_title_ru"
      t.string "guides_meta_title_en"
      t.text "guides_meta_description_ru"
      t.text "guides_meta_description_en"
      t.string "guides_meta_keywords_ru"
      t.string "guides_meta_keywords_en"
      t.datetime "created_at", default: "2018-09-18 07:34:07", null: false
      t.datetime "updated_at", default: "2018-09-18 07:34:07", null: false
      t.index ["avatar"], name: "index_avatar"
      t.index ["iso_code"], name: "index_iso_code"
      t.index ["large_avatar"], name: "index_large_avatar"
      t.index ["meta_description_en"], name: "index_meta_description_en"
      t.index ["meta_description_ru"], name: "index_meta_description_ru"
      t.index ["meta_keywords_en"], name: "index_meta_keywords_en"
      t.index ["meta_keywords_ru"], name: "index_meta_keywords_ru"
      t.index ["meta_title_en"], name: "index_meta_title_en"
      t.index ["meta_title_ru"], name: "index_meta_title_ru"
      t.index ["slug_en"], name: "index_slug_en"
      t.index ["slug_ru"], name: "index_slug_ru"
      t.index ["title_en"], name: "index_title_en"
    end
  end
end
