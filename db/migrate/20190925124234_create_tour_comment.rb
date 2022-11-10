class CreateTourComment < ActiveRecord::Migration[5.2]
  def change
    create_table :tour_comments do |t|
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
  end
end
