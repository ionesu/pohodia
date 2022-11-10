class CreateUser < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string "email", default: "", null: false
      t.string "encrypted_password", default: "", null: false
      t.string "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer "sign_in_count", default: 0, null: false
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string "current_sign_in_ip"
      t.string "last_sign_in_ip"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "provider"
      t.string "uid"
      t.bigint "role_id"
      t.string "avatar"
      t.string "name_ru"
      t.string "name_en"
      t.string "surname_ru"
      t.string "surname_en"
      t.integer "main_language_id"
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
      t.datetime "confirmed_at"
      t.string "confirmation_token"
      t.datetime "confirmation_sent_at"
      t.string "unconfirmed_email"
      t.index ["email"], name: "index_users_on_email", unique: true
      t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
      t.index ["role_id"], name: "index_users_on_role_id"
    end
  end
end
