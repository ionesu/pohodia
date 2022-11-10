class CreatePost < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
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
  end
end
