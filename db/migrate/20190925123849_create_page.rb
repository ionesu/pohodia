class CreatePage < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.string "title_ru", null: false
      t.string "title_en", null: false
      t.text "description_ru"
      t.text "description_en"
      t.string "slug_ru"
      t.string "slug_en"
      t.string "meta_title_ru"
      t.string "meta_title_en"
      t.text "meta_description_ru"
      t.text "meta_description_en"
      t.string "meta_keywords_ru"
      t.string "meta_keywords_en"
      t.string "descriptor"
      t.string "large_avatar"
      t.boolean "system", default: false, null: false
      t.index ["title_en"], name: "index_pages_on_title_en"
      t.index ["title_ru"], name: "index_pages_on_title_ru"
    end
  end
end
