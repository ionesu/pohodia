class CreateLanguage < ActiveRecord::Migration[5.2]
  def change
    create_table :languages do |t|
      t.string "title_ru"
      t.string "title_en"
      t.index ["title_en"], name: "index_languages_on_title_en"
      t.index ["title_ru"], name: "index_languages_on_title_ru"
    end
  end
end
