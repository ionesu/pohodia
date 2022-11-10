class CreateGuideCompany < ActiveRecord::Migration[5.2]
  def change
    create_table :guide_companies do |t|
      t.string "title_ru", null: false
      t.string "title_en", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "country_id"
      t.integer "region_id"
      t.integer "city_id"
      t.string "logo"
      t.string "address_ru"
      t.string "address_en"
      t.string "main_phone"
      t.string "additional_phone"
      t.string "email"
      t.text "description_ru"
      t.text "description_en"
      t.string "site"
      t.index ["title_en"], name: "index_guide_companies_on_title_en"
      t.index ["title_ru"], name: "index_guide_companies_on_title_ru"
    end
  end
end
