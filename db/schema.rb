# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_09_25_132054) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "administrators", force: :cascade do |t|
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
    t.hstore "role_permissions", default: {"tours"=>"false", "cities"=>"false", "regions"=>"false", "countries"=>"false", "seo_pages"=>"false", "tour_types"=>"false", "static_pages"=>"false", "tour_categories"=>"false"}, null: false
    t.index ["email"], name: "index_administrators_on_email", unique: true
    t.index ["reset_password_token"], name: "index_administrators_on_reset_password_token", unique: true
  end

  create_table "booking_statuses", force: :cascade do |t|
    t.string "title_ru", limit: 100
    t.string "title_en", limit: 100
    t.string "code", limit: 25
    t.index ["code"], name: "index_booking_statuses_on_code"
  end

  create_table "bookings", force: :cascade do |t|
    t.integer "tour_price_item_id"
    t.bigint "user_id"
    t.string "customer_email", limit: 100, null: false
    t.string "customer_phone", limit: 25
    t.string "customer_name", limit: 100
    t.string "customer_comment", limit: 500
    t.boolean "terms_agree", default: false
    t.boolean "privacy_agree", default: false
    t.integer "parties", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "booking_status_id"
    t.integer "tour_id"
    t.index ["booking_status_id"], name: "index_bookings_on_booking_status_id"
    t.index ["tour_price_item_id"], name: "index_bookings_on_tour_price_item_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "cities", force: :cascade do |t|
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

  create_table "countries", force: :cascade do |t|
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

  create_table "guide_companies", force: :cascade do |t|
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

  create_table "guide_company_permissions", force: :cascade do |t|
    t.integer "guide_company_id", null: false
    t.integer "guide_id", null: false
    t.boolean "access_to_tours", default: false, null: false
    t.boolean "access_to_company_info", default: false, null: false
    t.boolean "full_access", default: false, null: false
    t.index ["access_to_company_info"], name: "index_guide_company_permissions_on_access_to_company_info"
    t.index ["access_to_tours"], name: "index_guide_company_permissions_on_access_to_tours"
    t.index ["full_access"], name: "index_guide_company_permissions_on_full_access"
    t.index ["guide_company_id"], name: "index_guide_company_permissions_on_guide_company_id"
    t.index ["guide_id"], name: "index_guide_company_permissions_on_guide_id"
  end

  create_table "guide_identities", force: :cascade do |t|
    t.bigint "guide_id"
    t.string "provider"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guide_id"], name: "index_guide_identities_on_guide_id"
  end

  create_table "guides", force: :cascade do |t|
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

  create_table "import_requests", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string "title_ru"
    t.string "title_en"
    t.index ["title_en"], name: "index_languages_on_title_en"
    t.index ["title_ru"], name: "index_languages_on_title_ru"
  end

  create_table "menu_items", force: :cascade do |t|
    t.integer "menu_id"
    t.string "title_ru"
    t.string "title_en"
    t.string "link_ru"
    t.string "link_en"
    t.integer "position", default: 0, null: false
    t.index ["link_en"], name: "index_menu_items_on_link_en"
    t.index ["link_ru"], name: "index_menu_items_on_link_ru"
    t.index ["menu_id"], name: "index_menu_items_on_menu_id"
    t.index ["position"], name: "index_menu_items_on_position"
    t.index ["title_en"], name: "index_menu_items_on_title_en"
    t.index ["title_ru"], name: "index_menu_items_on_title_ru"
  end

  create_table "menus", force: :cascade do |t|
    t.string "title"
    t.string "descriptor"
    t.index ["descriptor"], name: "index_menus_on_descriptor"
    t.index ["title"], name: "index_menus_on_title"
  end

  create_table "pages", force: :cascade do |t|
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

  create_table "post_categories", force: :cascade do |t|
    t.string "title_ru", null: false
    t.string "title_en", null: false
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
    t.index ["title_en"], name: "index_post_categories_on_title_en"
    t.index ["title_ru"], name: "index_post_categories_on_title_ru"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title_ru", null: false
    t.string "title_en", null: false
    t.text "lead_ru"
    t.text "lead_en"
    t.integer "post_category_id", null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lead_en"], name: "index_posts_on_lead_en"
    t.index ["lead_ru"], name: "index_posts_on_lead_ru"
    t.index ["post_category_id"], name: "index_posts_on_post_category_id"
    t.index ["title_en"], name: "index_posts_on_title_en"
    t.index ["title_ru"], name: "index_posts_on_title_ru"
  end

  create_table "regions", force: :cascade do |t|
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

  create_table "seo_data_items", force: :cascade do |t|
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

  create_table "stories", force: :cascade do |t|
    t.string "title_ru"
    t.string "title_en"
    t.text "text_ru"
    t.text "text_en"
    t.integer "user_id"
    t.integer "administrator_id"
    t.integer "country_id"
    t.integer "region_id"
    t.integer "city_id"
    t.string "type_activity"
    t.string "image"
    t.string "large_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tour_category_id"
    t.integer "guide_id"
  end

  create_table "story_comment_photos", force: :cascade do |t|
    t.integer "story_comment_id", null: false
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "story_comments", force: :cascade do |t|
    t.integer "story_id"
    t.integer "user_id"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "story_images", force: :cascade do |t|
    t.integer "story_id"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "removed", default: false
  end

  create_table "tinymce_images", force: :cascade do |t|
    t.string "image"
    t.string "hint"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tour_categories", force: :cascade do |t|
    t.string "title_ru", null: false
    t.string "title_en", null: false
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
    t.integer "tour_type_id"
    t.index ["title_en"], name: "index_tour_categories_on_title_en"
    t.index ["title_ru"], name: "index_tour_categories_on_title_ru"
  end

  create_table "tour_comment_photos", force: :cascade do |t|
    t.bigint "tour_comment_id"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tour_comment_id"], name: "index_tour_comment_photos_on_tour_comment_id"
  end

  create_table "tour_comments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "tour_id"
    t.text "text"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "confirmed", default: false
    t.index ["tour_id"], name: "index_tour_comments_on_tour_id"
    t.index ["user_id"], name: "index_tour_comments_on_user_id"
  end

  create_table "tour_discussions", force: :cascade do |t|
    t.integer "administrator_id"
    t.integer "tour_id"
    t.text "text"
    t.boolean "confirmed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tour_images", force: :cascade do |t|
    t.integer "tour_id"
    t.integer "administrator_id"
    t.integer "guide_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image", null: false
    t.boolean "removed", default: false, null: false
    t.index ["administrator_id"], name: "index_tour_images_on_administrator_id"
    t.index ["guide_id"], name: "index_tour_images_on_guide_id"
    t.index ["tour_id"], name: "index_tour_images_on_tour_id"
  end

  create_table "tour_options", force: :cascade do |t|
    t.integer "tour_id"
    t.string "title_ru"
    t.string "title_en"
    t.integer "option_type", default: 0, null: false
    t.boolean "removed", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["option_type"], name: "index_tour_options_on_option_type"
    t.index ["removed"], name: "index_tour_options_on_removed"
    t.index ["title_en"], name: "index_tour_options_on_title_en"
    t.index ["title_ru"], name: "index_tour_options_on_title_ru"
    t.index ["tour_id"], name: "index_tour_options_on_tour_id"
  end

  create_table "tour_price_items", force: :cascade do |t|
    t.integer "tour_id"
    t.date "date_beginning"
    t.date "date_completion"
    t.integer "total_places", default: 1, null: false
    t.integer "free_places", default: 1, null: false
    t.integer "price", default: 100, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "deleted", default: false, null: false
    t.string "currency"
    t.index ["date_beginning"], name: "index_tour_price_items_on_date_beginning"
    t.index ["date_completion"], name: "index_tour_price_items_on_date_completion"
    t.index ["free_places"], name: "index_tour_price_items_on_free_places"
    t.index ["price"], name: "index_tour_price_items_on_price"
    t.index ["total_places"], name: "index_tour_price_items_on_total_places"
    t.index ["tour_id"], name: "index_tour_price_items_on_tour_id"
  end

  create_table "tour_route_points", force: :cascade do |t|
    t.integer "tour_route_id", null: false
    t.string "geo_latitude"
    t.string "geo_longitude"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tour_routes", force: :cascade do |t|
    t.integer "tour_id", null: false
    t.integer "sorting_postion", default: 0, null: false
    t.integer "type_accomodation", default: 0, null: false
    t.integer "type_of_food", default: 0, null: false
    t.integer "distance", default: 0, null: false
    t.integer "time_hours", default: 0, null: false
    t.string "image"
    t.string "geo_latitude"
    t.string "geo_longitude"
    t.boolean "wifi_enabled", default: false, null: false
    t.boolean "electricity_enabled", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "removed", default: false, null: false
    t.boolean "cellular_network_enabled", default: false, null: false
    t.string "title_ru"
    t.string "title_en"
    t.text "description_ru"
    t.text "description_en"
    t.time "time"
    t.index ["distance"], name: "index_tour_routes_on_distance"
    t.index ["electricity_enabled"], name: "index_tour_routes_on_electricity_enabled"
    t.index ["geo_latitude"], name: "index_tour_routes_on_geo_latitude"
    t.index ["geo_longitude"], name: "index_tour_routes_on_geo_longitude"
    t.index ["image"], name: "index_tour_routes_on_image"
    t.index ["sorting_postion"], name: "index_tour_routes_on_sorting_postion"
    t.index ["time_hours"], name: "index_tour_routes_on_time_hours"
    t.index ["tour_id"], name: "index_tour_routes_on_tour_id"
    t.index ["type_accomodation"], name: "index_tour_routes_on_type_accomodation"
    t.index ["type_of_food"], name: "index_tour_routes_on_type_of_food"
    t.index ["wifi_enabled"], name: "index_tour_routes_on_wifi_enabled"
  end

  create_table "tour_types", force: :cascade do |t|
    t.string "title_ru", null: false
    t.string "title_en", null: false
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
    t.index ["title_en"], name: "index_tour_types_on_title_en"
    t.index ["title_ru"], name: "index_tour_types_on_title_ru"
  end

  create_table "tours", force: :cascade do |t|
    t.integer "administrator_id"
    t.integer "country_id"
    t.integer "region_id"
    t.integer "city_id"
    t.integer "tour_type_id"
    t.integer "tour_category_id"
    t.string "avatar"
    t.integer "complexity", default: 1, null: false
    t.integer "min_height", default: 700, null: false
    t.integer "max_height", default: 1000, null: false
    t.integer "length_of_route", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "large_avatar"
    t.integer "guide_id"
    t.string "title_ru"
    t.string "title_en"
    t.string "description_ru"
    t.string "description_en"
    t.integer "global_status", default: 0, null: false
    t.datetime "deleted_at"
    t.integer "guide_company_id", default: 0
    t.integer "minimum_age", default: 5
    t.boolean "relocation_included", default: false, null: false
    t.boolean "confirmed", default: false
    t.boolean "many_days"
    t.boolean "has_booking_without_date", default: false
    t.boolean "has_booking", default: false
    t.integer "price"
    t.string "currency"
    t.string "external_url"
    t.string "location"
    t.string "avatar_external_url"
    t.index ["administrator_id"], name: "index_tours_on_administrator_id"
    t.index ["avatar"], name: "index_tours_on_avatar"
    t.index ["city_id"], name: "index_tours_on_city_id"
    t.index ["complexity"], name: "index_tours_on_complexity"
    t.index ["country_id"], name: "index_tours_on_country_id"
    t.index ["length_of_route"], name: "index_tours_on_length_of_route"
    t.index ["max_height"], name: "index_tours_on_max_heght"
    t.index ["min_height"], name: "index_tours_on_min_heght"
    t.index ["region_id"], name: "index_tours_on_region_id"
    t.index ["tour_category_id"], name: "index_tours_on_tour_category_id"
    t.index ["tour_type_id"], name: "index_tours_on_tour_type_id"
  end

  create_table "user_identities", force: :cascade do |t|
    t.bigint "user_id"
    t.string "provider"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_identities_on_user_id"
  end

  create_table "users", force: :cascade do |t|
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

  create_table "users_tours", force: :cascade do |t|
    t.integer "user_id"
    t.integer "tour_id"
  end

end
