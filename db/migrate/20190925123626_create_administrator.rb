class CreateAdministrator < ActiveRecord::Migration[5.2]
  def change
    enable_extension "hstore"
    enable_extension "plpgsql"

    create_table :administrators do |t|
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
      t.hstore "role_permissions", default: { "tours" => "false", "cities" => "false", "regions" => "false", "countries" => "false", "seo_pages" => "false", "tour_types" => "false", "static_pages" => "false", "tour_categories" => "false" }, null: false
      t.index ["email"], name: "index_administrators_on_email", unique: true
      t.index ["reset_password_token"], name: "index_administrators_on_reset_password_token", unique: true
    end
  end
end
