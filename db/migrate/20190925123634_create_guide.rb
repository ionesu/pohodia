class CreateGuide < ActiveRecord::Migration[5.2]
  def change
    create_table :guides do |t|
      t.string "email", default: "", null: false
      t.string "encrypted_password", default: "", null: false
      t.string "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer "sign_in_count", default: 0, null: false
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.inet "current_sign_in_ip"
      t.inet "last_sign_in_ip"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.boolean "full_access", default: false, null: false
      t.boolean "debug_mode", default: false, null: false
      t.string "name_ru"
      t.string "name_en"
      t.string "surname_ru"
      t.string "surname_en"
      t.integer "main_language_id"
      t.integer "additional_languages_ids", default: [], null: false, array: true
      t.text "description_ru"
      t.text "description_en"
      t.string "main_phone"
      t.string "additional_phone"
      t.string "contact_email"
      t.string "vk_link"
      t.string "instagram_link"
      t.string "facebook_link"
      t.integer "city_id"
      t.integer "region_id"
      t.integer "country_id"
      t.hstore "role_permissions", default: {"tours"=>"true", "profile"=>"true", "companies"=>"true"}, null: false
      t.string "avatar"
      t.index ["email"], name: "index_guides_on_email", unique: true
      t.index ["reset_password_token"], name: "index_guides_on_reset_password_token", unique: true
    end
  end
end
